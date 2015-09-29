# Genre Model
class Genre < ActiveRecord::Base
	# Validations
	
	# Relationships
	has_many :posts
end
