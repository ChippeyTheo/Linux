# TP4 : Real services

## Partie 1 : Partitionnement du serveur de stockage

**🌞 Partitionner le disque à l'aide de LVM**

```shell
[theo@localhost ~]$ sudo pvs
  Devices file sys_wwid t10.
  PV         VG      Fmt  Attr PSize  PFree
  /dev/sdb   storage lvm2 a--  <2.00g    0 
  /dev/sdc   storage lvm2 a--  <2.00g    0 
[theo@localhost ~]$ sudo vgs
  Devices file sys_wwid t10.
  VG      #PV #LV #SN Attr   VSize VFree
  storage   2   1   0 wz--n- 3.99g    0 
[theo@localhost ~]$ sudo lvs
  Devices file sys_wwid t10.
  LV         VG      Attr       LSize Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  LV_storage storage -wi-a----- 3.99g    

```

**🌞 Formater la partition**

```shell
[theo@localhost ~]$ sudo mkfs -t ext4 /dev/storage/LV_storage
```

**🌞 Monter la partition**

```shell
[theo@localhost ~]$ df -h | grep storage
/dev/mapper/storage-LV_storage  3.9G   24K  3.7G   1% /mnt/LV_storage1
```

```shell
[theo@localhost ~]$ df -h | grep LV
/dev/mapper/storage-LV_storage  3.9G  301M  3.4G   9% /mnt/LV_storage1
[theo@localhost ~]$ sudo dd if=/dev/random of=/mnt/LV_storage1/test bs=10M count=10
10+0 records in
10+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.628217 s, 167 MB/s
[theo@localhost ~]$ df -h | grep LV
/dev/mapper/storage-LV_storage  3.9G  401M  3.3G  11% /mnt/LV_storage1
```

```shell
[theo@localhost ~]$ cat /mnt/LV_storage1/test
```


## Partie 2 : Serveur de partage de fichiers

**🌞 Donnez les commandes réalisées sur le serveur NFS storage.tp4.linux**

```shell
1  sudo mkdir /storage/site_web_1/ -p
2  sudo mkdir /storage/site_web_2/ -p
3  ls -dl /storage/site_web_1/
4  ls -dl /storage/site_web_2/
5  sudo chown nobody /storage/site_web_1/
6  sudo chown nobody /storage/site_web_2/
7  sudo nano /etc/exports
8  sudo systemctl enable nfs-server
9  sudo systemctl start nfs-server
10  sudo systemctl status nfs-server
11  firewall-cmd --permanent --list-all | grep services
12  sudo firewall-cmd --permanent --add-service=nfs
13  sudo firewall-cmd --permanent --add-service=mountd
14  sudo firewall-cmd --permanent --add-service=rpc-bind
15  sudo firewall-cmd --reload
16  sudo firewall-cmd --permanent --list-all | grep services
```

```shell
[theo@localhost ~]$ cat /etc/exports
/storage/site_web_1 10.3.1.11(rw,sync,no_subtree_check)
/storage/site_web_2 10.3.1.11(rw,sync,no_subtree_check)
```

**🌞 Donnez les commandes réalisées sur le client NFS web.tp4.linux**

```shell 
14  sudo mkdir -p /var/www/site_web_1/
15  sudo mkdir -p /var/www/site_web_2/
16  sudo mount 10.3.1.12:/storage/site_web_1/ /var/www/site_web_1/
17  sudo mount 10.3.1.12:/storage/site_web_2/ /var/www/site_web_2/
18  df -h
29  sudo vi /etc/fstab 
30  sudo umount /var/www/site_web_1
35  sudo umount /var/www/site_web_2
31  df -h
32  sudo mount -av
33  df -h
49  history
```

```shell
[theo@localhost ~]$ cat /etc/fstab 
/dev/mapper/rl-root     /                       xfs     defaults        0 0

UUID=f534835d-8686-422c-a79e-24f80edeaed6 /boot                   xfs     defaults        0 0

/dev/mapper/rl-swap     none                    swap    defaults        0 0

10.3.1.12:/storage/site_web_1   /var/www/site_web_1 nfs defaults 0 0
10.3.1.12:/storage/site_web_2   /var/www/site_web_2 nfs defaults 0 0
```

```shell
[theo@localhost ~]$ df -h | grep site
10.3.1.12:/storage/site_web_1  6.2G  1.1G  5.2G  18% /var/www/site_web_1
10.3.1.12:/storage/site_web_2  6.2G  1.1G  5.2G  18% /var/www/site_web_2
```

## Partie 3 : Serveur web

### 1. Intro NGINX

