require 'test_helper'

class SeedsTest < ActionController::TestCase
  # Called after test
  def teardown
    Rake::Task["db:migrate:reset"].invoke
  end
    # Initial Seeds Testing
    test "Initial Seeds - Development" do
    ENV['RAILS_ENV'] ||= 'development'
    Rake::Task["db:seed"].invoke
  end
    test "Initial Seeds - Test" do
    ENV['RAILS_ENV'] ||= 'test'
    Rake::Task["db:seed"].invoke
  end
    test "Initial Seeds - Production" do
    ENV['RAILS_ENV'] ||= 'production'
    Rake::Task["db:seed"].invoke
  end
    # Secondary Seeds Testing
    test "Secondary Seeding - Development" do
    ENV['RAILS_ENV'] ||= 'development'
    Rake::Task["db:seed"].invoke
    Rake::Task["db:seed"].invoke
  end
    test "Secondary Seeding - Test" do
    ENV['RAILS_ENV'] ||= 'test'
    Rake::Task["db:seed"].invoke
    Rake::Task["db:seed"].invoke
  end
    test "Secondary Seeding - Production" do
    ENV['RAILS_ENV'] ||= 'production'
    Rake::Task["db:seed"].invoke
    Rake::Task["db:seed"].invoke
  end
end
