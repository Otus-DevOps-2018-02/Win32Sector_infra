# Win32Sector_infra
Win32Sector Infra repository

##############################################
##############################################

Homework-8

##############################################

In first task with asterisk, I created remote backend with file backend.tf, executed command 
```
terraform init
```
it's copied my local terraform state to remote storage in gcp.

Then, I move *tfstate files to temp dir outside infra repo and executed command
```
terraform plan
```
on stage and prod in one moment and receive this:
```
Acquiring state lock. This may take a few moments...

Error: Error locking state: Error acquiring the state lock: 2 error(s) occurred:

* writing "gs://storage-bucket-win32sector1/terraform/state/default.tflock" failed: googleapi: Error 412: Precondition Failed, conditionNotMet
* storage: object doesn't exist

Terraform acquires a state lock to protect the state from being written
by multiple users at the same time. Please resolve the issue above and try
again. For most commands, you can disable locking with the "-lock=false"
flag, but this is not recommended.
```

Yhis is work of state lock of state in remote state. Thisi s awesome! When I deploying my infrastructure, no one can destroy or broke it!

##############################################



##############################################
##############################################

Homework-7

##############################################

It was awesome task - second task, when I must to add ssh-keys for several other users to the project metadata.

The biggest trouble was to google how to do this. I don’t find ready-made solution and I created my own bicycle.

What I done:

- I created file public_keys.pub with four public keys for four users appeaser[1-4]
- I added new variable «public_keys» to variables.tf 
- I added value of «public_keys» to terraform.tfvars
- I added new resource to main.tf resource "google_compute_project_metadata_item" "keys" where I added variable public_keys, from file.

##############################################

Task with two asterisks

It was task, where I created http load balancer beetwen two app instances.

I done this with using 

```
"google_compute_forwarding_rule",
"google_compute_http_health_check",
"google_compute_target_pool".
```

There is was interesting task to create several instances using "count". 
I created variable "instance_names" in the file variables.tf with default values:

```
"0" = "reddit-app"
"1" = "reddit-app2"
```

and after it, I added to resource "google_compute_instance" "app" in the main.tf file, 

```
count = "2"
``` 

and

```
name  = "${lookup(var.instance_names, count.index)}"
```

I added to outputs.tf  

```
app_external_ip_reddit-app
app_external_ip_reddit_app2
load_balancer_ip
```

It so flexible! I can create any count of VMs using this. May be is hard way to realize this, but it works.

##############################################

Homework-5 cloud-testapp

##############################################

1. All commands from homework-5 was moved to three .sh scripts:
- install_ruby.sh
- install_mongodb.sh
- deploy.sh

##############################################

2. Was added startup-script.sh with all commands from our sripts from first task.
GCP WM created with command:

gcloud compute instances create test-startup-script-from-file \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=./startup-script.sh

##############################################

3. Next, startup-script.sh was uploaded to github gist and GCP VM created with command:

gcloud compute instances create test-startup-script-app-url\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata startup-script-url=https://gist.githubusercontent.com/Win32Sector/a0280fff7aba55c718cff22e01b96f02/raw/997ad71ca4919cdf561396045a86c2e925cc0f4b/gistfile1.txt

##############################################

4. Firewall rule default-puma-server was removed and was created again with gcloud command

gcloud compute firewall-rules create default-puma-server \
--action allow \
--direction ingress \
--rules tcp:9292 \
--source-ranges 0.0.0.0/0 \
--target-tags puma-server

I know, --action allow is default, but I wanted to point this out explicitly.

##############################################

Application config

testapp_IP = 35.204.234.123
testapp_port = 9292

##############################################
##############################################
##############################################

Homework-4 cloud-bastion

##############################################

How connect to someinternalhost in one command

ssh -i ~/.ssh/appuser -o "ProxyCommand ssh -W %h:%p appuser@35.204.134.171" appuser@10.164.0.3

Result:

Linux someinternalhost 4.9.0-6-amd64 #1 SMP Debian 4.9.82-1+deb9u3 (2018-03-02) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.

Last login: Wed Mar 14 09:15:06 2018 from 10.164.0.2
appuser@someinternalhost:~$

##############################################

How connect to someinternalhost with command "ssh someinternalhost"
For this we must add some lines to ssh config file.
Piece of my config here:

Host someinternalhost
 IdentityFile ~/.ssh/appuser
 HostName 10.164.0.3
 User appuser
 ProxyCommand ssh -i ~/.ssh/appuser -W %h:%p appuser@35.204.134.171

Result:

ssh someinternalhost
Linux someinternalhost 4.9.0-6-amd64 #1 SMP Debian 4.9.82-1+deb9u3 (2018-03-02) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.

Last login: Wed Mar 14 09:27:42 2018 from 10.164.0.2
appuser@someinternalhost:~$

##############################################
Configuration of GCP VMs:
Was created two VMs - bastion и someinternalhost

```
bastion_IP = 35.204.134.171
someinternalhost_IP = 10.164.0.3
```

On the bastion VM was installed VPN server Pritunl with setup file setupvpn.sh

Settings of Pritunl:

Organization: Win32Sector
Server: Win32Sector_server
user: test
pin: <PIN from homework 05>

Next, configuration .ovpn file was downloaded to my infra repo.

Was installed OVNP client - Tunnelblick and configuration file cloud-bastion.ovpn was tested.

Result:

ssh -vvvv -i ~/.ssh/appuser appuser@10.164.0.3

OpenSSH_7.6p1, LibreSSL 2.6.2

debug1: Reading configuration data /Users/win32sector/.ssh/config

debug1: /Users/win32sector/.ssh/config line 1: Applying options for *

debug1: Reading configuration data /etc/ssh/ssh_config

debug1: /etc/ssh/ssh_config line 48: Applying options for *

debug2: ssh_connect_direct: needpriv 0

debug1: Connecting to 10.164.0.3 port 22.

debug1: Connection established.

......

Linux someinternalhost 4.9.0-6-amd64 #1 SMP Debian 4.9.82-1+deb9u3 (2018-03-02) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Wed Mar 14 18:27:26 2018 from 10.164.0.2

appuser@someinternalhost:~$
