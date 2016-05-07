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
In order to deploy to Ubuntu Server, the following commands should be done first:

1. Clone repo into /var/www or move it using ```sudo mv FROM /var/www```
2. remove default site enabled with ```sudo rm /etc/nginx/conf.d/sites-enabled/default```
3. Move fakktion.conf to ```/etc/nginx/sites-available/fakktion.conf```
4. Create symbolic file ```sudo ln -sf /etc/nginx/sites-available/fakktion.conf /etc/nginx/sites-enabled/fakktion.conf```
5. Restart NGINX with ```sudo service nginx restart```
6. ~~Set a new secret base with ```SECRET_KEY_BASE=$(rake secret)```~~ Persisting ENV is not as straight forward, so instead edit the secrets.yml file, and don't make it available online under any circustance!!!
7. Setup Postgres to work with your app:
 - ```sudo -u postgres createuser --superuser $USER```
 - ```sudo -u postgres createdb $USER```
8. WIP

#### Start Server
To run server on the background, use -d as a parameter after production.
```
bundle exec puma -e production -b unix:///var/run/fakktion.sock 
```

#### Current Running Servers.
```
  ps aux | grep puma
```
#### Kill server
```
# kill -s SIGTERM SERVERPID
```
