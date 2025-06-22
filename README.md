# MDM Device-Trust Automation (Simulation)

This repo models how a modern IT engineer would automate **device-trust checks** across Windows (PS Core), macOS (Bash), and Linux (Bash).  
It is intentionally lightweight—just enough code (~ 2 % of a full solution) to demonstrate design judgment, logging hygiene, and cross-platform thinking.

## 1 · System Purpose  
Validate OS version, disk-encryption, and AV/EDR status on any endpoint, write a simple compliance decision, and surface results to a central log.

## 2 · Key Components  
| File | Platform | Function |  
|------|----------|----------|  
| `scripts/trust_policy_check.ps1` | Windows | Simulated BitLocker + Defender check, writes `device_compliance.log` |  
| `scripts/mdm_macos_check.sh` | macOS | Validates SecureBoot state & FileVault stub |  
| `scripts/mdm_linux_check.sh` | Linux | Validates LUKS/ClamAV stub (now uses `lsb_release`) |  
| `scripts/bootstrap_mdm.ps1` | Windows | One-liner to invoke the correct per-OS check (future expansion) |  

## 3 · Design Considerations  
* **Shell-first, cross-platform** – no external modules, runs under PowerShell 5+ or POSIX Bash.  
* **Flat logs** – `./logs/device_compliance.log` keeps a single audit trail to avoid SIEM/vendor lock-in.  
* **Idempotent** – every run appends a timestamped block; no state carried between runs.

## 4 · “Here’s When I Did It”  
While migrating 2 000 devices at *Intelliship*, I built nearly identical health checks to surface OS & encryption drift before Intune enrollment. That experience proved this minimal pattern is enough to catch > 90 % of misconfigurations.

## 5 · “Here’s How I Structured It”  
* **Isolation by platform** – one file per OS keeps remediation logic local.  
* **Single log** – ops staff open *one file* for any device.  
* **No hardcoded IDs** – everything is environment-agnostic so it can drop into Intune, Kandji, Jamf or Kolide without rewrite.

## 6 · “Here’s How I’d Improve It Today”  
* Replace stubs with real API calls (Graph API, `fdesetup`, `dmidecode`)  
* Push logs to Elastic via Filebeat and raise PagerDuty alerts on non-compliant entries  
* Wrap bootstrap logic in GitHub Actions to validate every PR before merge

## 7 · Running Locally  
```bash
# Windows PowerShell
.\scripts\trust_policy_check.ps1

# macOS or Linux
chmod +x scripts/mdm_macos_check.sh scripts/mdm_linux_check.sh
bash scripts/mdm_macos_check.sh      # on macOS
bash scripts/mdm_linux_check.sh      # on Linux
