# Ubuntu Server 16.04 Deployment
In order to deploy an ember-cli-rails project to Ubuntu Server 16.04, the following commands should be done first:

##WIP
1. Fork this project if you have not done so already!
2. Install Git Core ```sudo apt-get install git-core```
3. Now add yourself to the **www-data** group with ```sudo gpasswd -a "$USER" www-data```. This will prevent you from using sudo for commands which can become problematic if root become owner of a few files.
4. Go cd into /var/www, and clone repo through ```git clone https://github.com/YOURUSERNAME/Fakktion.git```
5. Navigate to Documents folder, and execute ```./base_reqs_16.sh```.
6. Now create a Postgres User with ```sudo -u postgres createuser --superuser $USER --pwprompt```. Don't forget to write down the password entered!
7. ```sudo -u $USER createdb fakktion```
8. Now navigate to secrets.yml, and change the production secret to not be an ENV var anymore. Afterwards, do the same thing for the database.yml with the info previously entered.
9. Navigate to Documents folder, and execute ```./install_reqs_16.sh```.
10. Precompile Fakktion with ```rake assets:precompile```.
11. Execute ```sudo ./setup_puma_16.sh``` to setup PUMA Daemon service through init.d.
12. If you need **SSL**, then open **fakktion_16_ssl.conf**. Otherwise open **fakktion_16_non_ssl.conf**.
13. Change hostname on the conf file if desired. ALso, you will need to change the certificate details if using the SSL version.
14. Execute ```sudo ./setup_nginx_16.sh``` to setup NGINX in order to put your app live.
15. ```sudo reboot```
16. WIP

### Running puma

```bundle exec puma -e production -d -b unix:///tmp/fakktion_puma.sock```
### Remove an App from PUMA
```sudo /etc/init.d/puma remove /path/to/app```
