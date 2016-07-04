# Ubuntu Server 14.04 Deployment **Deprecated guide**
In order to deploy an ember-cli-rails project to Ubuntu Server 14.04, the following commands should be done first: (Some info extracted from [Digital Ocean PUMA NGINX Guide](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04))

1. Fork this project if you have not done so already!
2. Install Git Core ```sudo apt-get install git-core```, and clone repo through ```git clone https://github.com/YOURUSERNAME/Fakktion.git```
3. Navigate to docs folder, and execute ```./u14deploy.sh 1```.
4. ```sudo -u postgres createuser --superuser $USER --pwprompt```
5. ```sudo -u $USER createdb fakktion```
6. Now navigate to secrets.yml, and change the production secret to not be an ENV var anymore. Afterwards, do the same thing for the database.yml
7. Navigate to Documents folder, and execute ```./u14deploy.sh 2``` (you will be asked to set a new password for your Postgres User, so use the one you wrote on database.yml), then precompile Fakktion with ```rake assets:precompile```.
8. PUMA SETUP:
 - ```nano /home/$USER/puma.conf``` and replace **setuid** and **setgid** apps to the deploying user.
 - Go to your $USER folder with ```cd /home/$USER```
 - Copy scripts into upstart services directory with ```sudo cp puma.conf puma-manager.conf /etc/init```
 - Now create the INV file with ```sudo nano /etc/puma.conf``` and add ```/home/DEPLOYING_USER/Fakktion```. When finished save it, and perform ```sudo reboot```.
9. NGINX SETUP:
 - Edit your fakktion.conf version to change from deovandski to your $USER.
 - Execute ```cd /home/$USER/Fakktion/Documents``` followed by  ```sudo ./u14deploy.sh 3```
10. Open your browser and navigate to ```http://server_public_IP/``` and you should see Hatsune Miku loading gif. If so, perform the following:
 - ```RAILS_ENV=production```
 - ```rake db:migrate```
 - ```rake db:seed```
11. Issues? Check the logs under /home/$USER/Fakktion/shared/log...

#### PUMA Application control
```
  sudo start puma-manager
  sudo stop puma-manager
  sudo restart puma-manager
```
