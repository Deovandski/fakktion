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
