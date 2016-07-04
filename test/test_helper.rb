require 'coveralls'
require 'active_support/json'
require 'active_model_serializers'

# Quick Note: Make sure to create the JSON schemas under support/schemas
# before procedding with the serialization tests.

Coveralls.wear!
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
class ActiveSupport::TestCase
  # Database Seed Coverage Test for both empty and filled DB.
  system("rake db:setup RAILS_ENV=test")
  system("rake db:seed RAILS_ENV=test")
  # Add more helper methods to be used by all tests here...
end
class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end
