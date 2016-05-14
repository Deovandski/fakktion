# Ubuntu Server 16.04 Deployment
In order to deploy an ember-cli-rails project to Ubuntu Server 16.04, the following commands should be done first:

## Initial Deploy
1. Fork this project if you have not done so already!
2. Run ```sudo apt-get update```.
3. Install Git Core ```sudo apt-get install -y git-core```
5. Clone repo through ```git clone https://github.com/YOURUSERNAME/Fakktion.git``` (HTTPS instead of SSH suggested as it will make it harder to accidently push commits back into origin master (or the branch that you use as master.)
6. Navigate to Fakktion/Documents folder, and execute ```./base_reqs_16.sh```.
7. Now create a Postgres User with ```sudo -u postgres createuser --superuser $USER --pwprompt```. Don't forget to write down the password entered!
8. ```sudo -u $USER createdb fakktion```
9. Now navigate to secrets.yml, and change the production secret to not be an ENV var anymore. You can whether run ```rake secret``` and paste over the ENV VAR, or just smash your keyboard A-Z/0-9 until you have the same amount of characters as the development secret. You could use ```nano FILE``` to edit the file.
10. Do the same thing for the database.yml with the info previously entered when you created the database.
11. Navigate to Documents folder, and execute ```./install_reqs_16.sh```.
12. Precompile Fakktion with ```rake assets:precompile```.
13. Move your app from your home folder to /var/www with ```sudo mv /home/$USER/Fakktion /var/www```
14. Navigate to the documents location with ```/var/www/Fakktion/Documents```
15. Execute ```sudo ./setup_puma_16.sh``` to setup PUMA Daemon service through init.d.
16. If you need **SSL**, then open **fakktion_16_ssl.conf**. Otherwise open **fakktion_16_non_ssl.conf**.
17. Change hostname on the conf file if desired. ALso, you will need to change the certificate details if using the SSL version.
18. Execute ```sudo ./setup_nginx_16.sh``` to setup NGINX in order to put your app live.
19. ```sudo reboot```

### Running puma
```bundle exec puma -e production -d -b unix:///tmp/fakktion_puma.sock```
### Check running PUMA apps
```ps aux | grep puma```
### Remove an App from PUMA
```sudo /etc/init.d/puma remove /path/to/app```
