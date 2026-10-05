# Windows Post-OSD Cleanup Script

Automatisierte PowerShell-Lösung zur Bereinigung von Windows-Systemen nach dem Deployment (OSDCloud / MDT / WDS / Autopilot).

## 📌 Übersicht

Beim Staging und Deployment von Windows-Systemen verbleiben häufig temporäre lokale Administrator-Konten (z. B. `lenovo`, `defaultuser0`) sowie temporäre Verzeichnisse für Treiber und Bereitstellungstools (`C:\Drivers`, `C:\OSDCloud`).

Dieses Skript führt eine automatisierte Bereinigung durch:

1. Entfernt definierte lokale Benutzerkonten.
2. Löscht die dazugehörigen Benutzerprofile sauber über CIM (`Win32_UserProfile`).
3. Entfernt rekursiv verbleibende Installations- und Treiberordner.

## 🚀 Verwendung

### Voraussetzungen

* Windows 10 / 11 / Windows Server
* Administratorrechte (`Run as Administrator`)

### Standardausführung

```powershell
Set-ExecutionPolicy Unrestricted -Scope Process -Force
.\scripts\Remove-OSDCleanupArtifacts.ps1
```

## 🛡️ Sicherheit & Compliance

Dieses Skript leistet einen wichtigen Beitrag zum **System-Hardening** und erhöht die Gesamtsicherheit der IT-Infrastruktur unmittelbar nach dem Staging:

* **Reduzierung der Angriffsfläche (Attack Surface Reduction):** Durch das konsequente Entfernen vordefinierter oder temporärer Administratorkonten (z. B. `lenovo`, `defaultuser0`) werden potenzielle Backdoors und unbefugte Zugriffswege eliminiert.
* **Schutz vor Privilege Escalation:** Verwaiste lokale Konten mit erhöhten Rechten sind ein häufiges Ziel bei Cyberangriffen. Das Löschen dieser Konten schließt diese Sicherheitslücke nachhaltig.
* **Saubere Datenbereinigung:** Das vollständige Löschen der Benutzerprofile über CIM (`Win32_UserProfile`) stellt sicher, dass keine sensiblen gecachten Anmeldedaten oder temporäre Dateien im System verbleiben.
