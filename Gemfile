source 'https://rubygems.org'

# Check for new releases...
# https://github.com/ember-cli/ember-cli/releases
# https://github.com/rails-api/active_model_serializers/releases

gem "foreman"
gem "local_time"
gem "puma"

group :development do
	# Graph generation tool
		gem "rails-erd"
	#http://docs.travis-ci.com/user/travis-lint/
		gem 'travis-lint'
	# Use Capistrano for deployment
		# gem 'capistrano-rails'
	# bundle exec rake doc:rails generates the API under doc/api.
		gem 'sdoc'
end
group :development, :test do
	# CodeClimate
		gem "codeclimate-test-reporter", require: nil
	# Travis CI
		gem "travis"
end

#https://github.com/rails-api/active_model_serializers
gem 'active_model_serializers', '0.10.0.rc3'

#EmberCLI
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
gem 'uglifier', '>= 2.7.1'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development

# Flexible authentication solution for Rails
gem 'devise'

# Use unicorn as the app server
# gem 'unicorn'

