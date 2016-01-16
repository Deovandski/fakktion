# The Fakktion Blog Source Code

![](/FakktionLogo.png)

[![Build Status][travis-badge]][travis] [![Test Coverage][testCoverage-badge]][testCoverage] [![Code Climate][codeClimate-badge]][codeClimate] [![Dependency Status][dependency-badge]][dependency] [![Security][security-badge]][security] [![Docs][docs-badge]][docs]

######Code Coverage, Docs and Dependencies badges are for Rails only...

All information about this project can be found on this [published paper](http://www.micsymposium.org/mics2015/ProceedingsMICS_2015/Skibinski_3C1_31.pdf). Information regarding the Database Design can be seen [Here](erd.pdf) while any other information can be seen in the documents below. However, if you prefer to watch a video, please check the [Fakktion Playlist](https://www.youtube.com/playlist?list=PLqBsvsbzH-lwDzspLWJwl2fdw61UO45j3) or watch the latest released [video](https://youtu.be/3da64yhFi4M). (Latest video represents progress until 8/26/2015.)

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
2. Install NPM, Bower and other requirements if you don't have them:
	1. sudo apt-get install npm
	2. sudo apt-get install nodejs-legacy (For Bower to work)
	3. sudo npm install -g bower
3. Bundle Install
4. Create new Secrets.yml. See [Extra Commands](Documents/Extra Commands.md) for more info.
5. Rake db:setup
6. cd frontend
7. npm install
8. bower install
9. npm install --save-dev ember-cli-rails-addon@0.7.0

Start the Server with '''rake start'''. To quickly login under Development mode, use the default account user@example.com with password 12345678.

## Documents

[Discussions regarding this project](Documents/Discussions.md)

[Code Information](Documents/Code Information.txt)

[Design Information](Documents/Design Information.txt)

[Planned Work](Documents/Planned Work.txt)

[Work History](Documents/Work History.txt)

[Extra Commands](Documents/Extra Commands.md)

## License

[The MIT License (MIT)](Documents/License.md)

Copyright (c) 2014 - 2015, Deovandski Skibinski Junior and Dr. Anne Denton
All rights reserved.

[travis]: https://travis-ci.org/Deovandski/Fakktion
[travis-badge]: https://travis-ci.org/Deovandski/Fakktion.svg?branch=master
[testCoverage]: https://codeclimate.com/github/Deovandski/Fakktion/coverage
[testCoverage-badge]: https://codeclimate.com/github/Deovandski/Fakktion/badges/coverage.svg
[codeClimate]: https://codeclimate.com/github/Deovandski/Fakktion
[codeClimate-badge]: https://codeclimate.com/github/Deovandski/Fakktion/badges/gpa.svg
[security]: https://hakiri.io/github/Deovandski/Fakktion/master
[security-badge]: https://hakiri.io/github/Deovandski/Fakktion/master.svg
[dependency]: https://gemnasium.com/Deovandski/Fakktion
[dependency-badge]: https://gemnasium.com/Deovandski/Fakktion.svg
[docs]: http://inch-ci.org/github/deovandski/fakktion/branch/master
[docs-badge]: https://inch-ci.org/github/deovandski/fakktion.svg?branch=master
