# The Fakktion Blog Source Code

![](/FakktionLogo.png)

####Project
[![Build Status][travis-badge]][travis] [![Code Climate][codeClimate-badge]][codeClimate] [![Dependency Status][dependency-badge]][dependency] [![Issues][issues-badge]][issues] [![Codebeat][codebeat-badge]][codebeat]

####Rails (Backend)
[![Security][security-badge]][security] [![Docs][docs-badge]][docs] [![Backend Coverage][backendCoverage-badge]][backendCoverage]

####Ember Cli (Frontend)

[![Frontend Coverage][frontendCoverage-badge]] [frontendCoverage]
 
[Live Website](http://fakktion.herokuapp.com/) (Initial load may be slow due to Dyno sleep mode implemented by [Heroku](https://www.heroku.com/pricing).)

All information about this project can be found on this [published paper](http://www.micsymposium.org/mics2015/ProceedingsMICS_2015/Skibinski_3C1_31.pdf). Information regarding the Database Design can be seen [Here](erd.pdf) while any other information can be seen in the documents below.

## Notice
This project once used [Ember-Rails](https://github.com/emberjs/ember-rails), but now it is using [Ember-cli-rails](https://github.com/rwz/ember-cli-rails). If you would like to see the previous Ember-Rails implementation, please check the [Ember-Rails Implementation branch](https://github.com/Deovandski/Fakktion/tree/Ember-Rails).

## Requirements

1. [Node.js](https://nodejs.org/)
2. [Npm](https://www.npmjs.com/)
3. [Bower](https://www.npmjs.com/package/bower)
4. [Ruby](https://www.ruby-lang.org/en/)
5. [Bundler](http://bundler.io/)

## Installation

1. Clone Project
2. Install NPM if you don't have it already:
  1. `sudo apt-get install npm`
  2. `sudo npm cache clean -f` (Clean cache to reduce issues.)
  3. `sudo npm install -g n`
  4. `sudo n stable`
  5. `sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}` (Force npm to be non-sudo.)
3. Install RVM, Ruby, Rails and Bundler if you don't have it already:
  1. `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`
  2. `\curl -sSL https://get.rvm.io | bash -s stable --ruby --rails` (Install RVM, Ruby and Rails)
  3. Reopen the terminal.
  4. `sudo apt-get install libpq-dev` (Requirement for pg gem)
  5. `gem install bundler`
4. Bundle Install
5. Rake db:setup
6. cd frontend
7. npm install
8. bower install

Start the Server with '''rake start'''. To quickly login under Development mode, use the default account user@example.com with password 12345678.

## Deployment

[Heroku](Documents/heroku.md) (~35 minutes for deployment)

[Ubuntu Server 14.04](Documents/Ubuntu Deployment.md) (~2 hours for deployment)

## Documents

[Discussions regarding this project](Documents/Discussions.md)

[Code Information](Documents/Code Information.txt)

[Design Information](Documents/Design Information.txt)

[Extra Commands](Documents/Extra Commands.md)

## License

[The MIT License (MIT)](Documents/License.md)

Copyright (c) 2014 - 2016, Deovandski Skibinski Junior and Dr. Anne Denton
All rights reserved.

[travis]: https://travis-ci.org/Deovandski/Fakktion
[travis-badge]: https://travis-ci.org/Deovandski/Fakktion.svg?branch=master
[frontendCoverage]: https://codeclimate.com/github/Deovandski/Fakktion/coverage
[frontendCoverage-badge]: https://codeclimate.com/github/Deovandski/Fakktion/badges/coverage.svg
[backendCoverage]: https://coveralls.io/github/Deovandski/Fakktion?branch=master
[backendCoverage-badge]: https://coveralls.io/repos/github/Deovandski/Fakktion/badge.svg?branch=master
[codeClimate]: https://codeclimate.com/github/Deovandski/Fakktion
[codeClimate-badge]: https://codeclimate.com/github/Deovandski/Fakktion/badges/gpa.svg
[security]: https://hakiri.io/github/Deovandski/Fakktion/master
[security-badge]: https://hakiri.io/github/Deovandski/Fakktion/master.svg
[dependency]: https://gemnasium.com/Deovandski/Fakktion
[dependency-badge]: https://gemnasium.com/Deovandski/Fakktion.svg
[codebeat]: https://codebeat.co/projects/github-com-deovandski-fakktion
[codebeat-badge]: https://codebeat.co/badges/21ac6d47-4e3b-4b35-ae94-a5901fa8e334
[docs]: http://inch-ci.org/github/deovandski/fakktion/branch/master
[docs-badge]: https://inch-ci.org/github/deovandski/fakktion.svg?branch=master
[issues]: https://codeclimate.com/github/Deovandski/Fakktion
[issues-badge]: https://codeclimate.com/github/Deovandski/Fakktion/badges/issue_count.svg
