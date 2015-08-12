# The Fakktion Blog Source Code

![](/FakktionLogo.png)

[![Build Status](travis-badge)](travis)[![Test Coverage](testCoverage-badge)](testCoverage)[![Code Climate](codeClimate-badge)](codeClimate)

######Code Coverage is for Rails only...

All information about this project can be found on this [published paper](http://www.micsymposium.org/mics2015/ProceedingsMICS_2015/Skibinski_3C1_31.pdf). Information regarding the Database Design and can be seen [Here](erd.pdf), and information about progress can be seen [Here](Documents/TODO.txt) and in this video [Here](https://youtu.be/tckjDm4LNjg) (Video represents progress as of 7/15/2015.)

## Notice
This project once used [Ember-Rails](https://github.com/emberjs/ember-rails), but now it is using [Ember-cli-rails](https://github.com/rwz/ember-cli-rails). If you would like to see the previous Ember-Rails implementation, please check the [Ember-Rails Implementation branch](https://github.com/Deovandski/Fakktion/tree/Ember-Rails).

## Installation

1. Clone Project
2. Create new Secrets.yml and place it on the config folder. See Extra Commands on the root folder.
3. Bundle Install
4. Rake db:migrate
5. Rake db:seed
6. bourbon install
7. neat install
8. cd frontend
9. npm install
10. bower install
11. Run the following commands to install addons:

```
npm install --save-dev ember-cli-rails-addon@0.0.11

ember install ember-cli-simple-auth

ember install ember-cli-simple-auth-devise

npm install ember-moment

npm install 

bower install

```

Start the Server with '''rake start'''. To quickly login under Development mode, please use the email as user@example.com and password as 12345678.

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
[codeClimate]: https://codeclimate.com/github/Deovandski/Fakktion/badges/gpa.svg
[codeClimate-badge]: https://codeclimate.com/github/Deovandski/Fakktion