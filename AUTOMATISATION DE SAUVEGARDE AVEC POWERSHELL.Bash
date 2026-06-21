####################################################################################################
# AUTOMATISATION DE SAUVEGARDE AVEC POWERSHELL
# Sauvegarde locale - Réseau - Rotation - Journalisation
####################################################################################################

########################################
# 1. VARIABLES DE CONFIGURATION
########################################

$Date = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

$Source = "C:\Documents"

$Destination = "D:\Sauvegardes"

$DossierBackup = "$Destination\Backup_$Date"

$LogFile = "$Destination\backup.log"

########################################
# 2. CRÉATION DU DOSSIER DE SAUVEGARDE
########################################

if (!(Test-Path $DossierBackup))
{
    New-Item `
        -ItemType Directory `
        -Path $DossierBackup `
        -Force
}

########################################
# 3. DÉMARRAGE DU JOURNAL
########################################

Add-Content `
    -Path $LogFile `
    -Value "[$(Get-Date)] Début de la sauvegarde"

########################################
# 4. SAUVEGARDE COMPLÈTE
########################################

Copy-Item `
    -Path $Source `
    -Destination $DossierBackup `
    -Recurse `
    -Force

########################################
# 5. FIN DE SAUVEGARDE
########################################

Add-Content `
    -Path $LogFile `
    -Value "[$(Get-Date)] Sauvegarde terminée"

Write-Host "Sauvegarde terminée avec succès"

####################################################################################################
# VERSION PROFESSIONNELLE AVEC ROBOCOPY
####################################################################################################

$Date = Get-Date -Format "yyyy-MM-dd"

$Source = "C:\Documents"

$Destination = "D:\Sauvegardes\$Date"

$Log = "D:\Sauvegardes\backup_$Date.log"

robocopy `
    $Source `
    $Destination `
    /MIR `
    /R:3 `
    /W:5 `
    /FFT `
    /Z `
    /XA:H `
    /V `
    /NP `
    /LOG:$Log

####################################################################################################
# SAUVEGARDE COMPRESSÉE ZIP
####################################################################################################

$Date = Get-Date -Format "yyyy-MM-dd"

$Source = "C:\Documents"

$ZipFile = "D:\Sauvegardes\Documents_$Date.zip"

Compress-Archive `
    -Path $Source `
    -DestinationPath $ZipFile `
    -Force

Write-Host "Archive créée : $ZipFile"

####################################################################################################
# ROTATION DES SAUVEGARDES
# Conservation : 30 jours
####################################################################################################

$BackupFolder = "D:\Sauvegardes"

$RetentionDays = 30

Get-ChildItem `
    -Path $BackupFolder `
    -Recurse |
Where-Object {
    $_.LastWriteTime -lt (Get-Date).AddDays(-$RetentionDays)
} |
Remove-Item `
    -Force `
    -Recurse

####################################################################################################
# SAUVEGARDE VERS UN PARTAGE RÉSEAU
####################################################################################################

$Source = "C:\Documents"

$Destination = "\\SERVEUR-FICHIERS\Backups"

robocopy `
    $Source `
    $Destination `
    /MIR `
    /Z `
    /R:3 `
    /W:5

####################################################################################################
# SAUVEGARDE DES BASES SQL SERVER
####################################################################################################

$Server = "SQL01"

$Database = "GestionProjet"

$BackupFile = "D:\SQLBackups\GestionProjet.bak"

Invoke-Sqlcmd `
    -ServerInstance $Server `
    -Query "
        BACKUP DATABASE [$Database]
        TO DISK = '$BackupFile'
        WITH INIT
    "

####################################################################################################
# PLANIFICATION AUTOMATIQUE VIA LE PLANIFICATEUR WINDOWS
####################################################################################################

$Action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-ExecutionPolicy Bypass -File C:\Scripts\Backup.ps1"

$Trigger = New-ScheduledTaskTrigger `
    -Daily `
    -At 22:00

Register-ScheduledTask `
    -TaskName "Sauvegarde Quotidienne" `
    -Action $Action `
    -Trigger $Trigger `
    -Description "Sauvegarde automatique quotidienne"

####################################################################################################
# RAPPORT DE SAUVEGARDE PAR EMAIL
####################################################################################################

$SMTPServer = "smtp.domaine.com"

$From = "backup@domaine.com"

$To = "admin@domaine.com"

$Subject = "Rapport de Sauvegarde"

$Body = @"
La sauvegarde automatique s'est terminée avec succès.

Date : $(Get-Date)

Serveur : $env:COMPUTERNAME
"@

Send-MailMessage `
    -SmtpServer $SMTPServer `
    -From $From `
    -To $To `
    -Subject $Subject `
    -Body $Body

####################################################################################################
# SCRIPT COMPLET ENTREPRISE
# - Sauvegarde
# - Compression
# - Journalisation
# - Rotation
# - Notification
####################################################################################################

$Date = Get-Date -Format "yyyy-MM-dd_HH-mm"

$Source = "C:\Documents"

$BackupRoot = "D:\Backups"

$TempBackup = "$BackupRoot\Backup_$Date"

$ZipFile = "$BackupRoot\Backup_$Date.zip"

$LogFile = "$BackupRoot\backup.log"

New-Item `
    -ItemType Directory `
    -Path $TempBackup `
    -Force

robocopy `
    $Source `
    $TempBackup `
    /MIR `
    /R:2 `
    /W:2

Compress-Archive `
    -Path $TempBackup `
    -DestinationPath $ZipFile `
    -Force

Remove-Item `
    $TempBackup `
    -Recurse `
    -Force

Add-Content `
    $LogFile `
    "[$(Get-Date)] Sauvegarde réalisée : $ZipFile"

Write-Host "Sauvegarde entreprise terminée avec succès"

####################################################################################################
# FIN
####################################################################################################