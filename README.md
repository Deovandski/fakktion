# The Fakktion Blog Source Code - Master Branch

![](/FakktionLogo.png)

####Project
[![Build Status][travis-badge]][travis] [![Code Climate][codeClimate-badge]][codeClimate] [![Dependency Status][dependency-badge]][dependency] [![Issues][issues-badge]][issues] [![Codebeat][codebeat-badge]][codebeat]

####Rails (Backend)
[![Security][security-badge]][security] [![Docs][docs-badge]][docs] [![Backend Coverage][backendCoverage-badge]][backendCoverage]
 
[Experimental Live Website](http://fakktion.herokuapp.com/) (In sync with master branch - Initial load may be slow due to Dyno sleep mode implemented by [Heroku](https://www.heroku.com/pricing).)

All information about this project can be found on this [published paper](http://www.micsymposium.org/mics2015/ProceedingsMICS_2015/Skibinski_3C1_31.pdf). Information regarding the Database Design can be seen [Here](erd.pdf) while any other information can be seen in the documents below.

## Notice
This project once used [Ember-Rails](https://github.com/emberjs/ember-rails), but now it is using [Ember-cli-rails](https://github.com/rwz/ember-cli-rails). If you would like to see the previous Ember-Rails implementation, please check the [Ember-Rails Implementation branch](https://github.com/Deovandski/Fakktion/tree/Ember-Rails).

## Development

1. Clone Project
2. Navigate to docs and execute ```sudo chmod +x u16dev.sh``` to allow script execution.
3. Install backend dependencies with ```. u16dev.sh 1 RVM?``` (Replace RVM? with y/n - No will install ruby through apt-get which you may have to update the gemfile ruby 2.3.X requirement.)
4. Install frontend dependencies with  ```. u16dev.sh 2```.
5. Install App dependencies with  ```. u16dev.sh 3 HerokuToolbet?``` (Replace HerokuToolbet? with y/n.)
6. Start the Server with '''rake start'''. To quickly login under Development mode, use the default account user@example.com with password 12345678.

## Server Deployment

[Heroku](docs/heroku.md) (~35 minutes for deployment)

[Ubuntu Server 14.04](docs/Ubuntu Deployment14.md) (~2 hours for deployment | Deprecated)

[Ubuntu Server 16.04](docs/Ubuntu Deployment16.md) (~1 hour for deployment)

## Server Maintenance

[Ubuntu Server 16.04](docs/Ubuntu Maintenance16.md)

## Documents

[Discussions regarding this project](docs/Discussions.md)

[Code Information](docs/Code Information.txt)

[Design Information](docs/Design Information.txt)

[Extra Commands](docs/Extra Commands.md)

## License

[The MIT License (MIT)](docs/License.md)

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
