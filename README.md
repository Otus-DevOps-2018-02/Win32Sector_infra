# Win32Sector_infra
Win32Sector Infra repository
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

bastion_IP = 35.204.134.171
someinternalhost_IP = 10.164.0.3

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