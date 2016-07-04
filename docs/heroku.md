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
