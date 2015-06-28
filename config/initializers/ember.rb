EmberCLI.configure do |config|
  config.app :frontend, path: Rails.root.join('frontend').to_s, build_timeout: 15
end
