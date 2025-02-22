# **README - Automatisation d'Installation Silencieuse et Exfiltration AnyDesk**

## **⚠️ Avertissement**

Ce script est strictement destiné à des **tests de sécurité et audits autorisé  et academique par rapport a mes cours de cybersecurité a la cité et mes CTFs s'il y a lieu ..** L'utilisation de ce script **sans consentement explicite** constitue une infraction à la loi  et je n'pas crée ce script dans de but malveillants.

---

## **🛠️ Description**

Ce script PowerShell permet :

- L'**installation furtive** d'AnyDesk sur une machine Windows.
- La **configuration de l'accès non surveillé** avec un mot de passe prédéfini.
- La **récupération automatique de l'ID AnyDesk** via des fichiers de configuration.
- L'**envoi de l'ID par Telegram** pour accès distant.
- Une **exécution automatique en mode administrateur**, même si lancé sans privilèges.

---

## **📚 Pré-requis**

- **Windows 10 / 11 / Server**
- **Exécution en mode Administrateur**
- Un **bot Telegram** configuré pour recevoir les messages

---

## **👉 Installation et Exécution**

### **1. Création et Configuration du Bot Telegram**

1. Ouvrir Telegram et rechercher **BotFather**
2. Exécuter la commande `/newbot` et suivre les instructions.
3. Récupérer le **Token API** du bot fourni par BotFather.
4. Obtenir l'ID de chat via **@userinfobot** en lui envoyant `/start`.

### **2. Exécution du Script PowerShell**

#### **Option 1 : Exécution manuelle**

1. Ouvrir **PowerShell en mode Administrateur**
2. Exécuter le script avec :
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force
   .\script.ps1
   ```

#### **Option 2 : Exécution avec un fichier batch**

1. Créer un fichier `run_script.bat` et y insérer :
   ```batch
   @echo off
   powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\PC1\Documents\script.ps1"
   ```
2. Lancer `run_script.bat` en **mode Administrateur**

---

## **🔧 Fonctionnalités du Script**

- **Exécution en mode Administrateur automatique**
- **Installation silencieuse d'AnyDesk**
- **Configuration du mot de passe Unattended Access**
- **Extraction de l'ID AnyDesk** via `system.conf` ou `ad_svc.trace`
- **Envoi automatique de l'ID sur Telegram**
- **Exécution furtive sans affichage**

---

## **🛡️ Contre-mesures et Détection**

### **1. Prévenir l'installation furtive**

- Bloquer **l'exécution de scripts PowerShell non signés** via GPO.
- Surveiller **les téléchargements suspects** avec un IDS (ex: `download.anydesk.com`).

### **2. Détection d'AnyDesk en mode furtif**

- Vérifier les services actifs :
  ```powershell
  Get-Service | Where-Object { $_.Name -like "AnyDesk" }
  ```
- Examiner les fichiers `C:\ProgramData\AnyDesk\*.*` pour repérer des configurations suspectes.

### **3. Surveiller la création de comptes cachés**

- Rechercher des utilisateurs inconnus dans les groupes `Administrateurs` :
  ```powershell
  net localgroup Administrators
  ```
- Auditer les clés de registre associées à `Winlogon\SpecialAccounts\Userlist`

### **4. Surveillance réseau**

- Identifier des connexions suspectes vers les serveurs AnyDesk via :
  ```powershell
  Get-NetTCPConnection | Where-Object { $_.RemoteAddress -match "anydesk" }
  ```

---

## **🔍 Analyse et Exploitation**

**Objectif du script :**

- Montrer comment **une attaque furtive** peut abuser d'un logiciel légitime.
- Démontrer les **failles de sécurité** et comment les contrer.
- Fournir une **preuve de concept** pour sensibiliser les équipes de sécurité.

---

## **🎉 Conclusion**

cela demontr comment un attaquant pourrait utiliser AnyDesk pour créer une **backdoor discrète**. 
---

## **✉ Contact & Support**

Si vous avez des questions sur cela , contactez moi sur telegram ou sur X .

