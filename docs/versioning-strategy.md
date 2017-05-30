Make sure that you have the ours driver merge set to true with ```git config --global merge.ours.driver true```. This is a must as both the README.md and /frontend/app/templates/index.hbs are kept in their own versions for each branch.

For all changes done on Master and ready to be tested, please merge it into the Heroku branch with

1. ```git checkout heroku```
2. ```git merge master```

Upon further test (including on the live test website) and no issues are found. Please push it into the ubuntu deployment branch with:

1. ```git checkout ubuntu```
2. ```git merge heroku```
