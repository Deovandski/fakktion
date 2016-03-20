require "codeclimate-test-reporter"
require 'active_support/json'
require 'active_model_serializers'

# Quick Note: Make sure to create the JSON schemas under support/schemas
# before procedding with the serialization tests.

CodeClimate::TestReporter.start
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
class ActiveSupport::TestCase
  # Use db:seed instead of fixtures.
  Rake::Task["db:seed"].invoke
  # Add more helper methods to be used by all tests here...
end
class ActionController::TestCase
  include Devise::TestHelpers    
end
