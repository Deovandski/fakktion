source 'https://rubygems.org'

# Maintain Ruby uptated version:

ruby "2.3.1"

# Rack Attack Middleware. https://github.com/kickstarter/rack-attack
gem 'rack-attack', '~> 4.4.1'

gem "foreman", '~> 0.82'
gem "local_time", '~> 1.0'

# Webserver
gem "puma", '~> 3.4.0'

# AMS
gem 'active_model_serializers', '~> 0.10.1'

# EmberCLI
gem 'ember-cli-rails', '~> 0.7.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.6'

# Sanitize Post Text
gem 'rails-html-sanitizer', '~> 1.0.3'

# CSS related stuff
gem 'sass-rails', '~> 5.0.5'
gem "awesome_print", '~> 1.7.0'
gem "font-awesome-rails", '~> 4.6.3'
gem 'bourbon', '~> 4.2.7'
gem 'neat', '~> 1.8.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.1.1'

# Flexible authentication solution for Rails
gem 'devise', '~> 4.1.1'

# Development Group
group :development do
  # Graph generation tool
  gem "rails-erd", '~> 1.4.7'
  # Bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.1'
  # Spring speeds up development by keeping your application running in the background.
  gem 'spring', '~> 1.7.1'
end

# Test Group
group :development, :test do

  # JSON Schema for comparison Assert test.
  gem "json_schema", '~> 0.13.0'
  # Code Climate
  gem 'coveralls', require: false
  # Travis CI
  gem "travis", '~> 1.8.2'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.3.11'
end

# Production Group
group :production, :staging do
  # Heroku related gem
  gem 'rails_12factor', '~> 0.0.3'
  # Postgres (Database)
  gem "pg", '~> 0.18.4'
end

