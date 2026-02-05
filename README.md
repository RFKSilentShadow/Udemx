# UDEMX DevOps Task (Vagrant + Ansible + k3s)

## Goal
This repository contains a full automated solution for the DevOps task.  
After cloning the repo, run:

```bash
vagrant up
```

The provisioning will:
- Install Debian 11 VM
- Configure users, SSH, firewall, fail2ban
- Install Kubernetes (k3s), Helm
- Deploy nginx ingress + self-signed TLS
- Deploy MariaDB with `udemx` user + database
- Deploy a demo app returning **Hello UDEMX!**
- Create scripts under `/opt/scripts`
- Install Jenkins + private Docker registry + Portainer

## Requirements
- Vagrant
- kvm
- Ansible installed locally with libvirt plugin

## Access
- SSH: port **2222**
- Default VM IP: `192.168.56.50`
- Jenkins: `http://192.168.56.50:8080`
- Docker Registry UI: `http://192.168.56.50:8081`
- Hello Udemx!: `https://udemx.local/`
- Demo App (Wordpress): `https://wordpress.udemx.local/`

## Accessing the Demo Applications

To access the **Hello UDEMX** page and the **PHP Laravel demo application** via a browser, you need to add the following entry to your local hosts file.

On the host machine, edit `/etc/hosts` (Linux/macOS) or  
`C:\Windows\System32\drivers\etc\hosts` (Windows) and add:
- `192.168.56.50 udemx.local` 
- `192.168.56.50 wordpress.udemx.local`

## Mounting /tmp Partition

The VM comes with /tmp configured on a separate disk (/dev/vdc1), but it may not be mounted automatically.

A script has been provided in /opt/udemx/mount-tmp.sh:

`sudo /opt/udemx/mount-tmp.sh`


What it does:

- Mounts /dev/vdc1 to /tmp if not already mounted
- Adds the entry to /etc/fstab for persistence across reboots

After running the script or role, /tmp will be on its dedicated partition and survive VM reboots.