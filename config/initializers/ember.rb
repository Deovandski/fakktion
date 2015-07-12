#Dirty fix for https://github.com/rwz/ember-cli-rails/issues/88
module EmberCLI
  class App
    EMBER_CLI_VERSION = "~> 1.13.0"
  end
end
EmberCLI.configure do |config|
  config.app :frontend, path: Rails.root.join('frontend').to_s, build_timeout: 30
end
