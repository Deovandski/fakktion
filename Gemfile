source 'https://rubygems.org'
ruby "2.2.3"

# Check for new releases...
# https://github.com/ember-cli/ember-cli/releases
# https://github.com/rails-api/active_model_serializers/releases

gem "foreman"
gem "local_time"
gem "puma"

group :development do
	# Graph generation tool
		gem "rails-erd"
	# http://docs.travis-ci.com/user/travis-lint/
		gem 'travis-lint'
	# Use Capistrano for deployment
		# gem 'capistrano-rails'
	# Bundle exec rake doc:rails generates the API under doc/api.
		gem 'sdoc'
	# Spring speeds up development by keeping your application running in the background.
		gem 'spring'
end
group :development, :test do
	# Code Climate
		gem "codeclimate-test-reporter", require: nil
	# Travis CI
		gem "travis"
end
# https://github.com/rails-api/active_model_serializers
gem 'active_model_serializers', '0.10.0.rc3'

# EmberCLI
gem 'ember-cli-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# CSS related stuff
gem 'sass-rails'
gem "awesome_print"
gem "font-awesome-rails"
gem 'neat'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Flexible authentication solution for Rails
gem 'devise'

# Use unicorn as the app server
# gem 'unicorn'


gem 'rails_12factor', group: [:staging, :production]
