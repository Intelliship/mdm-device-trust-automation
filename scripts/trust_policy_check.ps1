# Step 0: Setup Log File Directory
$logDir = "./logs"
if (-not (Test-Path -Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir | Out-Null
}

$logFile = "$logDir/device_compliance.log"

# Simulated Compliance Checks
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$osVersion = (Get-CimInstance -ClassName Win32_OperatingSystem).Version
$expectedOSVersion = "10.0.19045"      # Mocked expected version
$bitLockerStatus = "Enabled"           # Mocked value
$avStatus = "Running"                  # Mocked value

# Log Results
Add-Content -Path $logFile -Value "$timestamp : Starting compliance check"
Add-Content -Path $logFile -Value "$timestamp : OS Version = $osVersion (Expected: $expectedOSVersion)"
Add-Content -Path $logFile -Value "$timestamp : Disk Encryption = $bitLockerStatus"
Add-Content -Path $logFile -Value "$timestamp : Antivirus Service = $avStatus"

# Simulate Compliance Outcome
if ($osVersion -eq $expectedOSVersion -and $bitLockerStatus -eq "Enabled" -and $avStatus -eq "Running") {
    Add-Content -Path $logFile -Value "$timestamp : Device is compliant"
} else {
    Add-Content -Path $logFile -Value "$timestamp : Device is NOT compliant"
}
