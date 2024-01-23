# TP1 : Casser avant de construire

## I. Casser

### 1. Fichier

**🌞 Supprimer des fichiers**

Se rendre à la **racine**, puis dans le dossier **boot** et enfin supprimer le(s) noyau(x) présent (ici : vmlinuz...). Si l'user n'a pas la permission. Passer en super-user et supprimer.

### 2. Utilisateurs

**🌞 Mots de passe**

sudo passwd nom_user
changer un mdp
 
cat /etc/passwd --> liste des users
cat /etc/shadow --> liste des mdp

**🌞 Another way ?**

sudo usermod theo -s /sbin/nologin

### 3. Disques

**🌞 Effacer le contenu du disque dur**

note: sudo usermod -aG wheel theo
pour erreur 

fdisk -l: montre les disk
lsblk : plus direct
sudo dd if=/dev/zero of=/dev/le_disk_a_remplir_de_zero bs=4M
dd if=<source> of=<cible> bs=<taille des blocs>

### 4. Malware

**🌞 Reboot automatique**

