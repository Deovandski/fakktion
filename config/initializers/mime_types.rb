# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf

# From http://stackoverflow.com/questions/32491360/deserializing-json-api-with-rails-strong-parameters
Mime::Type.register "application/json", :json, %w( text/x-json application/jsonrequest application/vnd.api+json )
