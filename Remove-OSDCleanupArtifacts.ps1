<#
.SYNOPSIS
    Entfernt temporäre Benutzerkonten und verbleibende Ordner nach dem System-Deployment (OSDCloud / MDT / WDS).

.DESCRIPTION
    Das Skript führt Bereinigungsarbeiten nach Abschluss der BS-Installation durch:
    - Löscht temporäre lokale Benutzer (z. B. lenovo, defaultuser0) und deren Profile.
    - Löscht Treiber-Verzeichnisse und temporäre OSDCloud-Ordner.

.PARAMETER TargetUsers
    Array von Benutzernamen, die gelöscht werden sollen.

.PARAMETER TargetFolders
    Array von Ordnerpfaden, die gelöscht werden sollen.

.EXAMPLE
    .\Remove-OSDCleanupArtifacts.ps1

.NOTES
    Autor: Nurlan Bakenbaev
    Rolle: Systemadministrator / Fachinformatiker für Systemintegration
#>

param(
    [string[]]$TargetUsers = @("lenovo", "defaultuser0"),
    [string[]]$TargetFolders = @("C:\Drivers", "C:\OSDCloud")
)

# "Dieses Skript muss mit Administratorrechten ausgeführt werden!"

Write-Host "=== Start der Systembereinigung nach OSD ===" -ForegroundColor Cyan

# 1. Lokale Benutzer und Benutzerprofile löschen
foreach ($user in $TargetUsers) {
    try {
        # Lokales Benutzerkonto entfernen
        if (Get-LocalUser -Name $user -ErrorAction SilentlyContinue) {
            Remove-LocalUser -Name $user -ErrorAction Stop
            Write-Host "[+] Benutzerkonto '$user' erfolgreich gelöscht." -ForegroundColor Green
        } else {
            Write-Host "[-] Benutzer '$user' nicht gefunden." -ForegroundColor Gray
        }

        # Benutzerprofil über CIM entfernen
        $userProfile = Get-CimInstance -ClassName Win32_UserProfile | Where-Object { $_.LocalPath -like "*\$user" }
        if ($userProfile) {
            Remove-CimInstance -InputObject $userProfile -ErrorAction Stop
            Write-Host "[+] Benutzerprofil '$user' erfolgreich aus C:\Users entfernt." -ForegroundColor Green
        }
    } catch {
        Write-Error "Fehler beim Löschen des Benutzers '$user': $_"
    }
}
# 2. Temporäre Verzeichnisse löschen
foreach ($folder in $TargetFolders) {
    try {
        if (Test-Path -Path $folder -PathType Container) {
            Remove-Item -Path $folder -Recurse -Force -ErrorAction Stop
            Write-Host "[+] Ordner '$folder' erfolgreich gelöscht." -ForegroundColor Yellow
        } else {
            Write-Host "[-] Ordner '$folder' nicht gefunden." -ForegroundColor Gray
        }
    } catch {
        Write-Error "Fehler beim Löschen des Ordners '$folder': $_"
    }
}
Write-Host "=== Bereinigung abgeschlossen ===" -ForegroundColor Green