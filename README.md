# UDEMX DevOps Task (Vagrant + Ansible + k3s)

## Requirements
- Vagrant
- libvirt / KVM installed on host
- Vagrant libvirt plugin (`vagrant-libvirt`)
- Ansible installed locally
- python passlib

## SSH Keys Configuration (Required)
Before running `vagrant up`, you must configure your own SSH key paths in the main Ansible playbook. These keys will get copied into the guest host, so you may want to generate new ones for testing purposes.

Open the playbook (ansible/playbook.yml) and set the following variables:
```yaml
host_ssh_pub_key: "<your_ssh_pubkey_path>"
host_git_ssh_private_key: "<your_ssh_privkey_path>"
```

### Example
```yaml
host_ssh_pub_key: "/home/user/.ssh/id_rsa.pub"
host_git_ssh_private_key: "/home/user/.ssh/id_rsa"
```

## Goal
This repository contains a fully automated solution for the DevOps task.  
After cloning the repo, run:

```bash
sudo vagrant up --provider=libvirt
```

The provisioning will:
- Install Debian 11 VM
- Configure users, SSH, firewall, fail2ban
- Install Kubernetes (k3s), Helm
- Deploy nginx ingress + self-signed TLS
- Deploy MariaDB with `udemx` user + database
- Deploy Wordpress as demo app connecting to database
- Deploy app returning **Hello UDEMX!**
- Create scripts under `/opt/scripts`
- Install Jenkins + private Docker registry

## Access
NOTE: Non-application service ports are not open by default. You may access the necessary ports through an SSH tunnel:
```
ssh -R 8080:localhost:8080 -R 8081:localhost:8081 -R 6443:localhost:6443 -N -f udemx@192.168.56.50 
```

### Accessing the Demo Applications 
To access the **Hello UDEMX** page and the **PHP Laravel demo application** via a browser, you need to add the following entry to your local hosts file.

On the host machine, edit `/etc/hosts` (Linux/macOS) or  
`C:\Windows\System32\drivers\etc\hosts` (Windows) and add:
- `192.168.56.50 udemx.local` 
- `192.168.56.50 wordpress.udemx.local`
- SSH: port **2222**

### Locations
- Default VM IP: `192.168.56.50`
- Jenkins: `http://192.168.56.50:8080`
- Docker Registry UI: `http://192.168.56.50:8081`
- Hello Udemx!: `https://udemx.local/`
- Demo App (Wordpress): `https://wordpress.udemx.local/`

## vim exit command
`:q`
