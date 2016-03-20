require 'test_helper'

class DatabaseTest < ActionController::TestCase
  test "Seeding Test" do
    Rails.logger.debug "Initial Seeding"
    Rake::Task["db:seed"].invoke
    Rails.logger.debug "Force reload to test counter methods."
    Rake::Task["db:seed"].invoke
  end
end

