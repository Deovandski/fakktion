# Ubuntu Server 16.04 Deployment
In order to deploy an ember-cli-rails project to Ubuntu Server 16.04, the following commands should be done first:

##WIP
1. Fork this project if you have not done so already!
2. Install Git Core ```sudo apt-get install git-core```, and clone repo through ```git clone https://github.com/YOURUSERNAME/Fakktion.git```
3. Navigate to Documents folder, and execute ```./base_reqs_16.sh```.
4. ```sudo -u postgres createuser --superuser $USER --pwprompt```
5. ```sudo -u $USER createdb fakktion```
6. Now navigate to secrets.yml, and change the production secret to not be an ENV var anymore. Afterwards, do the same thing for the database.yml
7. Navigate to Documents folder, and execute ```./install_reqs_16.sh``` (you will be asked to set a new password for your Postgres User, so use the one you wrote on database.yml), then precompile Fakktion with ```rake assets:precompile```.
8. PUMA SETUP: 
 - WIP
9. NGINX SETUP: 
 - WIP
