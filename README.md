# UDEMX DevOps Task (Vagrant + Ansible + k3s)

## Requirements
- Vagrant
- libvirt / KVM installed on host
- Vagrant libvirt plugin (`vagrant-libvirt`)
- Ansible installed locally
- python passlib

## SSH Keys Configuration (Required)
Before running `vagrant up`, you must configure your own SSH key paths in the main Ansible playbook.

Open the playbook (ansible/playbook.yml) and set the following variables:
```yaml
host_ssh_pub_key: "<your_ssh_pubkey_path>"
```

### Example
```yaml
host_ssh_pub_key: "/home/user/.ssh/id_rsa.pub"
```

### Jenkins SSH Private Key (Required)

The Jenkins pipeline also requires an SSH private key.

Using the private key from the GitHub Gist (see Jenkins section below), create the following file inside the repository:
`ansible/roles/jenkins/files/udemx-ssh-key`
Paste the full private key content into this file:
```
-----BEGIN OPENSSH PRIVATE KEY-----
...
-----END OPENSSH PRIVATE KEY-----
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
ssh -L 8080:localhost:8080 -L 8081:localhost:8081 -L 6443:localhost:6443 -N udemx@192.168.56.50 -p 2222 
```

## Jenkins Pipeline Setup (Required Manual Step)

For the Jenkins pipeline / Jenkins job to work, you must manually add an SSH private key credential.

### Steps

1. Open Jenkins: [http://192.168.56.50:8080](http://192.168.56.50:8080)
2. Navigate to: Manage Jenkins → Credentials → System → Global credentials (unrestricted)
3. Click **Add Credentials**

4. Fill in the form as follows:

- **Kind:** SSH Username with private key
- **ID:** `github-ssh`
- **Username:** *(leave empty)*
- **Private Key:** Select **Enter directly**
- [Paste the SSH private key from](https://gist.github.com/RFKSilentShadow/d4542b39423bfa914cfc47b9101d27e0)    
5. Save.

### Run the Jenkins Job

After adding the credential:

1. Go back to Jenkins dashboard
2. Open the job named **`udemx`**
3. Click **Build Now**

The pipeline will run successfully.

From this point onward, the Jenkins job will work automatically.

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
