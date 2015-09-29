# Category Model
class Category < ActiveRecord::Base
	# Validations
	
	# Relationships
	has_many :posts
end
