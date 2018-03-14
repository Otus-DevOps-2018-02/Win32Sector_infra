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


