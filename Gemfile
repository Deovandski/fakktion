source 'https://rubygems.org'

# Maintain Ruby uptated version:

ruby "2.3.0"

gem "foreman", '>=0.82'
gem "local_time", '>=1.0'

# Webserver
gem "puma", '>=3.4'

# AMS
gem 'active_model_serializers', '0.10.0'

# EmberCLI
gem 'ember-cli-rails', '0.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Sanitize Post Text
gem 'rails-html-sanitizer'

# CSS related stuff
gem 'sass-rails', '>=5.0'
gem "awesome_print", '>=1.6'
gem "font-awesome-rails", '>=4.6'
gem 'bourbon', '>=4.2.7'
gem 'neat'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>=2.7'

# Use jquery as the JavaScript library
gem 'jquery-rails', '>=4.1'

# Flexible authentication solution for Rails
gem 'devise', '>=4.1.1'

# Development Group
group :development do
  # Graph generation tool
  gem "rails-erd", '>=1.4'
  # http://docs.travis-ci.com/user/travis-lint/
  gem 'travis-lint', '>=2.0'
  # Bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '>=0.4'
  # Spring speeds up development by keeping your application running in the background.
  gem 'spring', '>=1.6'
end

# Test Group
group :development, :test do

  # JSON Schema for comparison Assert test.
  gem "json_schema", '0.12.3'
  # Code Climate
  gem 'coveralls', require: false
  # Travis CI
  gem "travis", '>=1.8'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '>=1.3'
end

# Production Group
group :production, :staging do
  # Heroku related gem
  gem 'rails_12factor', '>=0.0.3'
  # Postgres (Database)
  gem "pg", '>=0.18'
end

