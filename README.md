# AUTOMATISATION DE SAUVEGARDE AVEC POWERSHELL

## Présentation

Ce projet regroupe plusieurs scripts PowerShell permettant d'automatiser les opérations de sauvegarde dans un environnement professionnel.

Les scripts couvrent :

- Sauvegarde locale de fichiers et dossiers
- Sauvegarde réseau
- Compression ZIP
- Journalisation des opérations
- Rotation automatique des anciennes sauvegardes
- Sauvegarde de bases de données SQL Server
- Planification automatique des tâches
- Notifications par courrier électronique
- Sauvegarde complète de niveau entreprise

L'objectif est de garantir la protection des données, la continuité des activités et la réduction des interventions manuelles.

---

# Objectifs pédagogiques

À la fin de ce projet, vous serez capable de :

- Automatiser les sauvegardes avec PowerShell
- Utiliser Copy-Item et Robocopy
- Générer des archives ZIP
- Mettre en place une politique de rétention
- Sauvegarder des bases SQL Server
- Créer des tâches planifiées Windows
- Envoyer des notifications automatiques
- Produire des journaux d'exécution

---

# Architecture des scripts

```text
Documents
│
├── Sauvegarde locale
│
├── Sauvegarde réseau
│
├── Compression ZIP
│
├── Rotation automatique
│
├── Sauvegarde SQL Server
│
├── Tâches planifiées
│
├── Notification Email
│
└── Sauvegarde Entreprise
```

---

# 1. Sauvegarde locale

## Description

Cette partie effectue une copie complète des fichiers depuis un dossier source vers un dossier de sauvegarde horodaté.

### Fonctionnalités

- Création automatique du dossier de destination
- Copie récursive
- Écrasement des fichiers existants
- Journalisation des opérations

### Technologies utilisées

- Copy-Item
- Test-Path
- New-Item
- Add-Content

---

# 2. Journalisation des sauvegardes

## Description

Toutes les opérations importantes sont enregistrées dans un fichier journal.

### Exemple d'informations enregistrées

```text
[2026-06-21 20:00:01] Début de la sauvegarde
[2026-06-21 20:02:15] Sauvegarde terminée
```

### Avantages

- Audit
- Traçabilité
- Diagnostic rapide

---

# 3. Sauvegarde professionnelle avec Robocopy

## Description

Robocopy est l'outil recommandé par Microsoft pour les sauvegardes professionnelles.

### Options utilisées

| Option | Description |
|----------|------------|
| /MIR | Miroir complet |
| /R:3 | 3 tentatives |
| /W:5 | Attente 5 secondes |
| /FFT | Compatibilité FAT |
| /Z | Mode redémarrable |
| /XA:H | Ignore les fichiers cachés |
| /V | Mode détaillé |
| /NP | Pas de pourcentage |
| /LOG | Journalisation |

### Avantages

- Très rapide
- Gestion des erreurs
- Compatible réseau
- Reprise automatique

---

# 4. Compression ZIP

## Description

Après la sauvegarde, les données peuvent être compressées afin d'économiser l'espace disque.

### Cmdlet utilisée

```powershell
Compress-Archive
```

### Avantages

- Réduction de l'espace utilisé
- Archivage simplifié
- Transport plus facile

---

# 5. Rotation automatique

## Description

Les anciennes sauvegardes sont supprimées automatiquement après une durée définie.

### Paramètre

```powershell
$RetentionDays = 30
```

### Fonctionnement

Le script :

- Parcourt le dossier de sauvegarde
- Recherche les fichiers anciens
- Supprime les éléments dépassant la période de conservation

### Avantages

- Évite le remplissage du disque
- Gestion automatique du stockage

---

# 6. Sauvegarde réseau

## Description

Les données peuvent être copiées vers un serveur de fichiers.

### Exemple

```text
\\SERVEUR-FICHIERS\Backups
```

### Cas d'utilisation

- Serveur NAS
- Serveur Windows
- Stockage centralisé

### Avantages

- Protection contre les pannes locales
- Centralisation des sauvegardes

---

# 7. Sauvegarde SQL Server

## Description

Cette section effectue une sauvegarde complète d'une base de données SQL Server.

### Commande utilisée

```sql
BACKUP DATABASE GestionProjet
TO DISK='GestionProjet.bak'
```

### Avantages

- Protection des bases de données
- Reprise après incident
- Conformité aux bonnes pratiques DBA

---

# 8. Planification automatique

## Description

Les sauvegardes peuvent être exécutées automatiquement chaque jour.

### Heure configurée

```text
22:00
```

### Composants utilisés

- New-ScheduledTaskAction
- New-ScheduledTaskTrigger
- Register-ScheduledTask

### Résultat

Le serveur exécute automatiquement le script sans intervention humaine.

---

# 9. Notification par Email

## Description

Un rapport est envoyé à l'administrateur après chaque sauvegarde.

### Informations envoyées

- Date d'exécution
- Nom du serveur
- État de la sauvegarde

### Avantages

- Surveillance proactive
- Réactivité en cas de problème

---

# 10. Sauvegarde Entreprise Complète

## Description

Le script final combine plusieurs mécanismes :

### Étapes

1. Création du dossier temporaire
2. Sauvegarde via Robocopy
3. Compression ZIP
4. Suppression du dossier temporaire
5. Journalisation
6. Notification

### Avantages

- Processus entièrement automatisé
- Réduction de l'espace disque
- Conservation des historiques
- Facilité d'administration

---

# Cas d'utilisation

## PME

- Sauvegarde quotidienne des documents

## Administration publique

- Archivage des données administratives

## Universités

- Sauvegarde des travaux de recherche

## Hôpitaux

- Protection des données critiques

## Entreprises

- Plan de reprise d'activité (PRA)

---

# Prérequis

## Système

- Windows 10
- Windows 11
- Windows Server 2016+
- PowerShell 5.1 ou supérieur

## Modules optionnels

```powershell
SqlServer
ScheduledTasks
```

---

# Exécution

## Exécution manuelle

```powershell
powershell.exe -ExecutionPolicy Bypass -File Backup.ps1
```

## Exécution automatique

```powershell
Planificateur de tâches Windows
```

---

# Bonnes pratiques

- Utiliser plusieurs emplacements de sauvegarde
- Tester régulièrement la restauration
- Conserver les journaux
- Chiffrer les sauvegardes sensibles
- Mettre en place une rotation adaptée
- Surveiller l'espace disque disponible

---

# Compétences acquises

À travers ce projet, vous apprendrez :

- PowerShell Administration
- Automatisation système
- Gestion des sauvegardes
- Journalisation
- Compression de données
- Administration SQL Server
- Administration Windows Server
- Gestion des tâches planifiées
- PRA (Plan de Reprise d'Activité)
- Bonnes pratiques DevOps et Infrastructure

---

# Auteur
MUHINDO KISUMBA
Projet pédagogique PowerShell orienté :

- Administration Système
- Infrastructure IT
- DevOps
- Cybersécurité défensive
- Gestion des sauvegardes professionnelles

---

# Licence

Utilisation libre à des fins :

- Éducatives
- Académiques
- Professionnelles
- Laboratoires de formation
- Démonstrations techniques

---
FIN DU README
