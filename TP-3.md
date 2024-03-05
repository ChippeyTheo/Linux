# TP3 : Services

## I. Service SSH

### 1. Analyse du service

**🌞 S'assurer que le service sshd est démarré**

```shell
[theo@node1 ~]$ systemctl status sshd
● sshd.service - OpenSSH server daemon
     Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; preset: enabled)
     Active: active (running) since Mon 2024-01-29 15:16:16 CET; 37min ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 689 (sshd)
      Tasks: 1 (limit: 4672)
     Memory: 4.9M
        CPU: 332ms
     CGroup: /system.slice/sshd.service
             └─689 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
```

**🌞 Analyser les processus liés au service SSH**

```shell
[theo@node1 ~]$ ps -A | grep sshd
    689 ?        00:00:00 sshd
   1377 ?        00:00:00 sshd
   1381 ?        00:00:00 sshd
```

**🌞 Déterminer le port sur lequel écoute le service SSH**

```shell
[theo@node1 ~]$ sudo ss -alnpt | grep ssh
[sudo] password for theo: 
LISTEN 0      128          0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=689,fd=3))
LISTEN 0      128             [::]:22           [::]:*    users:(("sshd",pid=689,fd=4))
```

**🌞 Consulter les logs du service SSH**

```shell
[theo@node1 ~]$ journalctl -xe -u sshd
Jan 29 15:53:29 node1.tp3.b1 sshd[1377]: main: sshd: ssh-rsa algorithm is disabled
Jan 29 15:53:31 node1.tp3.b1 sshd[1377]: Accepted password for theo from 10.3.1.10 port 60960 ssh2
Jan 29 15:53:31 node1.tp3.b1 sshd[1377]: pam_unix(sshd:session): session opened for user theo(uid=1000) by (uid=0)
```

### 2. Modification du service

**🌞 Identifier le fichier de configuration du serveur SSH**

```shell
[theo@node1 ~]$ sudo cat /etc/ssh/sshd_config
```

**🌞 Modifier le fichier de conf**

```shell
[theo@node1 ~]$ echo $RANDOM
5555
[theo@node1 ~]$ sudo cat /etc/ssh/sshd_config | grep Port
Port 5555
#GatewayPorts no
```
```shell
[theo@node1 ~]$ sudo firewall-cmd --list-all | grep ports -i
  ports: 5555/tcp
``` 
-i pour pas prendre en compte maj/min

**🌞 Redémarrer le service**

```shell
[theo@node1 ~]$ sudo systemctl restart sshd
```

**🌞 Effectuer une connexion SSH sur le nouveau port**

```shell
ssh -p 5555 theo@10.3.1.11
```

## II. Service HTTP

### 1. Mise en place

**🌞 Installer le serveur NGINX**

```shell
[theo@node1 ~]$ sudo dnf install nginx
```

**🌞 Démarrer le service NGINX**

```shell
[theo@node1 ~]$ sudo systemctl start nginx
[theo@node1 ~]$ echo $?
0
```

**🌞 Déterminer sur quel port tourne NGINX**

```shell
[theo@node1 ~]$ cd /etc/nginx/
[theo@node1 nginx]$ grep -rni "listen " | grep -v "#"
nginx.conf:39:        listen       80;
nginx.conf:40:        listen       [::]:80;
nginx.conf.default:36:        listen       80;
```
ou bien  
```
[theo@node1 nginx]$ echo 80
80
```

**🌞 Déterminer les processus liés au service NGINX**

```shell
[theo@node1 nginx]$ ps -ef | grep nginx
root        1712       1  0 15:16 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx       1713    1712  0 15:16 ?        00:00:00 nginx: worker process
theo        1908    1487  0 16:05 pts/0    00:00:00 grep --color=auto nginx
```

**🌞 Déterminer le nom de l'utilisateur qui lance NGINX**

```shell
[theo@node1 nginx]$ cat /etc/passwd | grep nginx
nginx:x:991:991:Nginx web server:/var/lib/nginx:/sbin/nologin
```

**🌞 Test !**

```shell
theo@theo-MacBookPro:~$ curl 10.3.1.11:80 -s | head -n 7
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
```

### 2. Analyser la conf de NGINX

**🌞 Déterminer le path du fichier de configuration de NGINX**

```shell
[theo@node1 ~]$ ls -al /etc/nginx/nginx.conf
-rw-r--r--. 1 root root 2334 Oct 16 20:00 /etc/nginx/nginx.conf
```

**🌞 Trouver dans le fichier de conf**