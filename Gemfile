source 'https://rubygems.org'
ruby "2.3.0"

gem "foreman"
gem "local_time"

# Webserver
gem "puma"

# https://github.com/rails-api/active_model_serializers
gem 'active_model_serializers', '0.10.0.rc3'

# EmberCLI
gem 'ember-cli-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

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

# Development Group
group :development do
	# Graph generation tool
	gem "rails-erd"
	# http://docs.travis-ci.com/user/travis-lint/
	gem 'travis-lint'
	# Bundle exec rake doc:rails generates the API under doc/api.
	gem 'sdoc'
	# Spring speeds up development by keeping your application running in the background.
	gem 'spring'
end

# Test Group
group :development, :test do
	# Code Climate
	gem "codeclimate-test-reporter", require: nil
	# Travis CI
	gem "travis"
	# Use sqlite3 as the database for Active Record
	gem 'sqlite3'
end

# Production Group
group :production, :staging do
	# Heroku related gem
	gem 'rails_12factor'
	# Postgres (Database)
	gem "pg"
end

