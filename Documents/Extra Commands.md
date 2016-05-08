#### Create Database diagram
```
rake erd
```
#### Fully reset DB and redo all migrations
```
rake db:migrate:reset
```
#### git return file state to previous commit
```
git reset --hard
```
#### Bundler commands
```
http://bundler.io/v1.5/commands.html
```
#### Testing json response
```
http://localhost:3000/api/v1/genres.json // for all of them
http://localhost:3000/api/v1/genres/1.json // for individual response
```
#### Clear Cache
```
rake tmp:clear
```
#### fix public SSH key issue
```
ssh-add -l (The agent has no identities message will shown up)
ssh-add "Key"
ssh-add -l (to verify agent)
```
#### Update Ember-CLI
```
npm uninstall -g ember-cli
npm cache clean
bower cache clean
npm install -g ember-cli
rm -rf node_modules bower_components dist tmp
npm install --save-dev ember-cli
add "ember-simple-auth": "0.8.0" to bower.json
bower install
ember install ember-cli-simple-auth
ember init -- Generate new project blueprint... Make sure to review diff!
rake start and install any mising add-on	
```
#### Validating .travis.yml files
```
travis-lint command from main folder
```
#### Encrypt secrets through Travis CI
```
travis login --org
travis encrypt-file config/secrets.yml --add
```

#### Ubuntu change file permission back from sudo.
```
sudo chown -R username file
```

#### Bcrypt installation with native extensions troubleshoot
```
sudo apt-get install aptitude
sudo aptitude install libgmp-dev
sudo aptitude install build-essential
```
# Heroku
#### Heroku pushing new version to heroku:master (If Heroku is not hooked to TravisCI Test builds) 
```
[Heroku Toolbelt link in case it is not installed](https://toolbelt.heroku.com/)
git push heroku master
heroku ps:scale web=1
heroku ps
heroku open
```
#### Purge Heroku cache manually 
```
heroku run bash
rm -rf node_modules
rm -rf frontend/node_modules
rm -rf bower_components
rm -rf frontend/bower_components
npm start OR Push a commit to TravisCI (or even directly to Heroku) 
```

# Ubuntu Server Deployment
In order to deploy an ember-cli-rails project to Ubuntu Server, the following commands should be done first:

1. Write the following ENV variables to .profile using ```nano ~/.profile```. 
 - ```SKB="XXXXXXXXXXXXXXX"```
 - ```RAILS_ENV="XXXXXXXXXXXXX"```
 - ```FAKKTION_DATABASE_USER="XXXXXXXXXXXXXX"```
 - ```FAKKTION_DATABASE_PASSWORD="XXXXXXXXXXXXXXXXX"```
 - ```FAKKTION_PRODUCTION_DATABASE="XXXXXXXXXXXXXXXXX"```
4. Install Git Core ```sudo apt-get install git-core```, and clone repo through ```git clone https://github.com/Deovandski/Fakktion.git```
5. Navigate to Documents folder, and execute ```./ubuntu_deploy_script_1.sh```
6. PUMA SETUP: (Some info extracted from this [Digital Ocean Guide](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04))
 - Navigate to Documents folder, and execute ```./ubuntu_deploy_script_2.sh```
 - Edit puma.conf through ```nano puma.conf``` and replace **setuid** and **setgid** apps to the deploying user (/home/$USER in this case)
 - ```sudo cp puma.conf puma-manager.conf /etc/init```
 - Edit the inventory file now through ```sudo nano /etc/puma.conf``` and add ```/home/$USER/Fakktion```
 - ```sudo start puma-manager```
7. NGINX SETUP: (Some info extracted from this [Digital Ocean Guide](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04)) 
 - Navigate to Documents folder, and execute ```./ubuntu_deploy_script_3.sh```
 - Navigate to ```http://server_public_IP/tasks```

#### PUMA Application control
```
  sudo start puma-manager
  sudo stop puma-manager
  sudo restart puma-manager
```
