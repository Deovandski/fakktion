EmberCLI.configure do |config|
  config.build_timeout = 10 
  config.app :frontend, path: Rails.root.join('frontend').to_s
end
