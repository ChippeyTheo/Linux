# TP2 : Appréhension d'un système Linux

## Partie 1: Files and users

### 1. Find me

**🌞  Trouver le chemin vers le répertoire personnel de votre utilisateur**

```bash
ls -al /home/theo/
``````

**🌞 Trouver le chemin du fichier de logs SSH**

```bash
sudo cat /var/log/secure
```

**🌞 Trouver le chemin du fichier de configuration du serveur SSH**

```bash
sudo cat /etc/ssh/sshd_config
```

### 1.bis Nouveau user

**🌞 Créer un nouvel utilisateur**

```bash
useradd marmotte
passwd marmotte

sudo usermod -d /home/papier_alu/ -m marmotte
```

possible de directement faire :

```bash
sudo useradd -d /home/papier_alu/ -m marmotte
```

### 2. Infos enregistrées par le système

**🌞 Prouver que cet utilisateur a été créé**

```bash
[marmotte@localhost theo]$ cat /etc/passwd | grep marmotte
marmotte:x:1001:1001::/home/papier_alu/:/bin/bash
```

**🌞 Déterminer le hash du password de l'utilisateur marmotte**

```bash
[theo@localhost ~]$ sudo cat /etc/shadow | grep marmotte
[sudo] password for theo: 
marmotte:$6$vnWBaV/eWiRpQNNM$xh9KYtqu4P/acDKChaf0qoAHiKkfz3.lYrAvvtZguvaymiywMxTLaSDL2LQrafNJ9iu9.bjTWehj3rALuTnub/:19744:0:99999:7:::
```


marmotte --> nom de mon user  
6 --> sha256  
vnWBaV/eWiRpQNNM --> sel  
hash --> xh9KYtqu4P/acDKChaf0qoAHiKkfz3.lYrAvvtZguvaymiywMxTLaSDL2LQrafNJ9iu9.bjTWehj3rALuTnub/  

### 3. Connexion sur le nouvel utilisateur

**🌞 Tapez une commande pour vous déconnecter : fermer votre session utilisateur**

```bash
exit
```

**🌞 Assurez-vous que vous pouvez vous connecter en tant que l'utilisateur marmotte**

```bash
[marmotte@localhost theo]$ ls /home/theo/
ls: cannot open directory '/home/theo/': Permission denied
```

## Partie 2 : Programmes et paquets

### I. Programmes et processus

#### 1. Run then kill

**🌞 Lancer un processus sleep**

```bash
[theo@localhost ~]$ ps -ef | grep sleep
theo        1570    1300  0 15:55 tty1     00:00:00 sleep 1000
theo        1572    1329  0 15:55 pts/0    00:00:00 grep --color=auto sleep
[theo@localhost ~]$ kill 1570
[theo@localhost ~]$ ps -ef | grep sleep
theo        1574    1329  0 15:57 pts/0    00:00:00 grep --color=auto sleep
```

**🌞 Terminez le processus sleep depuis le deuxième terminal**

```bash
[theo@localhost ~]$ kill 1570
[theo@localhost ~]$ ps -ef | grep sleep
theo        1574    1329  0 15:57 pts/0    00:00:00 grep --color=auto sleep
```


#### 2. Tâche de fond

**🌞 Lancer un nouveau processus sleep, mais en tâche de fond**

```bash
[theo@localhost ~]$ sleep 1000&
```

**🌞 Visualisez la commande en tâche de fond**

```bash
[theo@localhost ~]$ jobs -p
1624
```

#### 3. Find paths

**🌞 Trouver le chemin où est stocké le programme sleep**

```bash
[theo@localhost ~]$ which sleep
/usr/bin/sleep
[theo@localhost ~]$ ls -al /usr/bin/ | grep sleep
-rwxr-xr-x.  1 root root   36312 Apr 24  2023 sleep
```

**🌞 Tant qu'on est à chercher des chemins : trouver les chemins vers tous les fichiers qui s'appellent .bashrc**

```bash
[theo@localhost ~]$ sudo find / -name "*.bashrc"
[sudo] password for theo: 
/etc/skel/.bashrc
/root/.bashrc
/home/theo/.bashrc
/home/papier_alu/.bashrc
```

#### 4. La variable PATH

**🌞 Vérifier que**

```bash
[theo@localhost ~]$ which sleep
/usr/bin/sleep
[theo@localhost ~]$ which ssh
/usr/bin/ssh
[theo@localhost ~]$ which ping
/usr/bin/ping
```

### II. Paquets

**🌞 Installer le paquet git**

```bash 
[theo@localhost ~]$ sudo dnf install git
```

**🌞 Utiliser une commande pour lancer git**

```bash
[theo@localhost ~]$ which git
/usr/bin/git
```

**🌞 Installer le paquet nginx**

```bash
[theo@localhost ~]$ sudo dnf install nginx
```

**🌞 Déterminer**

```bash
[theo@localhost ~]$ sudo find / -name nginx 
/etc/logrotate.d/nginx
/etc/nginx
/var/lib/nginx
/var/log/nginx
/usr/sbin/nginx
/usr/lib64/nginx
/usr/share/nginx
```

```bash
[theo@localhost ~]$ sudo find / -name nginx.conf
/etc/nginx/nginx.conf
```

**🌞 Mais aussi déterminer...**
