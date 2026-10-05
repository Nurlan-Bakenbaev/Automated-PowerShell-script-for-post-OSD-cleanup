# Windows Post-OSD Cleanup Script

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%20%7C%207.x-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

An automated PowerShell solution for cleaning up Windows operating systems immediately following deployment (OSDCloud / MDT / WDS / Autopilot).

## 📌 Overview

During OS staging and deployment, temporary local administrator accounts (such as `lenovo` or `defaultuser0`) and staging directories for drivers and provisioning tools (`C:\Drivers`, `C:\OSDCloud`) are frequently left behind. 

This script automates the post-deployment hygiene process by:
1. Deleting specified local user accounts.
2. Completely unregistering and wiping associated user profiles via CIM (`Win32_UserProfile`).
3. Recursively removing leftover installation and driver directories.

## 🚀 Usage

### Prerequisites
* Windows 10 / 11 / Windows Server
* Administrator privileges (`Run as Administrator`)

### Standard Execution
```powershell
Set-ExecutionPolicy Unrestricted -Scope Process -Force
.\scripts\Remove-OSDCleanupArtifacts.ps1
```

## 🛡️ Security & Compliance

This script directly contributes to **System Hardening** and enhances the security posture of the infrastructure right after provisioning:

* **Attack Surface Reduction (ASR):** Consistently removes predefined or temporary administrative accounts, closing potential backdoors and unauthorized access vectors.
* **Privilege Escalation Protection:** Orphaned local accounts with administrative rights are prime targets in lateral movement attacks. Removing them mitigates this vulnerability.
* **Data Sanitization:** Removing user profiles via CIM (`Win32_UserProfile`) ensures cached credentials and temporary session files are thoroughly wiped from disk.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.