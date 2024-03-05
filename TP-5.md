# TP5 : We do a little scripting

## Partie 1 : Script carte d'identité

**🌞 Vous fournirez dans le compte-rendu Markdown, en plus du fichier, un exemple d'exécution avec une sortie**

```shell
theo@theo-MacBookPro:~/YNOV/Linux$ ./idcard.sh 
Machine name : theo-MacBookPro
OS Ubuntu 22.04.3 LTS and kernel version is 6.5.0-21-generic
IP : 10.33.72.90/20
RAM : 639Mo memory available on 8177Mo total memory
Disk : 50G space left
Top 5 processes by RAM usage :
  - firefox
  - Discord
  - systemd-journald
  - gnome-shell
  - firefox
Listening ports :
  - 631 udp : cups-browsed
  - 5353 udp : avahi-daemon
  - 42545 udp : firefox
  - 42933 udp : avahi-daemon
  - 53 udp : systemd-resolve
  - 631 tcp : cupsd
  - 6463 tcp : Discord
  - 53 tcp : systemd-resolve
PATH directories :
  - /usr/local/sbin
  - /usr/local/bin
  - /usr/sbin
  - /usr/bin
  - /sbin
  - /bin
  - /usr/games
  - /usr/local/games
  - /snap/bin
  - /snap/bin
Here is your random cat (jpg file) : https://cdn2.thecatapi.com/images/afc.jpg
```

## Partie 2 : Script youtube-dl

### 1. Premier script youtube-dl

#### A. Le principe