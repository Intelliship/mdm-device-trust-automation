#!/bin/bash

LOGFILE="./logs/device_compliance.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Simulated compliance values
EXPECTED_OS="Ubuntu 22.04"
OS_VERSION=$(lsb_release -d | cut -f2-)
DISK_ENCRYPTION="Enabled"     # Stub – simulate `lsblk` or `cryptsetup`
AV_STATUS="Running"           # Stub – simulate `clamav`, `sophos`, etc.

mkdir -p ./logs

echo "$TIMESTAMP : Starting compliance check" >> "$LOGFILE"
echo "$TIMESTAMP : OS Version = $OS_VERSION (Expected: $EXPECTED_OS)" >> "$LOGFILE"
echo "$TIMESTAMP : Disk Encryption = $DISK_ENCRYPTION" >> "$LOGFILE"
echo "$TIMESTAMP : Antivirus Service = $AV_STATUS" >> "$LOGFILE"

if [[ "$OS_VERSION" == *"$EXPECTED_OS"* && "$DISK_ENCRYPTION" == "Enabled" && "$AV_STATUS" == "Running" ]]; then
    echo "$TIMESTAMP : Device is compliant" >> "$LOGFILE"
else
    echo "$TIMESTAMP : Device is NOT compliant" >> "$LOGFILE"
fi
