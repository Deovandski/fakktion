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
In order to deploy an ember-cli-rails project to Ubuntu Server 14.04, the following commands should be done first: (Some info extracted from [Digital Ocean PUMA NGINX Guide](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04))

1. Fork this project if you have not done so already!
2. Install Git Core ```sudo apt-get install git-core```, and clone repo through ```git clone https://github.com/YOURUSERNAME/Fakktion.git```
3. Navigate to Documents folder, and execute ```./base_reqs.sh``` followed by ```sudo ./set_envs.sh```
4. Checkout ```sudo nano /etc/default/locale``` and confirm the ENV VARS created (Make sure that there are no spaces between constant and value.) Write down those values as you will need most of them.
5. Now navigate to secrets.yml, and change the production secret to not be an ENV var anymore. Afterwards, do the same thing for the database.yml
6. Navigate to Documents folder, and execute ```./install_reqs.sh``` (you will be asked to set a new password for your Postgres User, so use the one you wrote on database.yml), then precompile Fakktion with ```rake assets:precompile```.
7. PUMA SETUP: 
 - ```nano /home/$USER/puma.conf``` and replace **setuid** and **setgid** apps to the deploying user.
 - Go to your $USER folder with ```cd /home/$USER```
 - Copy scripts into upstart services directory with ```sudo cp puma.conf puma-manager.conf /etc/init```
 - Now create the INV file with ```sudo nano /etc/puma.conf``` and add ```/home/DEPLOYING_USER/Fakktion```. When finished save it, and perform ```sudo reboot```.
8. NGINX SETUP:
 - Edit your fakktion.conf version to change from deovandski to your $USER.
 - Execute ```cd /home/$USER/Fakktion/Documents``` followed by  ```sudo ./set_nginx.sh```
 - Open your browser and navigate to ```http://server_public_IP/```

9. Issues? Check the logs under /home/$USER/Fakktion/shared/log...
#### PUMA Application control
```
  sudo start puma-manager
  sudo stop puma-manager
  sudo restart puma-manager
```
