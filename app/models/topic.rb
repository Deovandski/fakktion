# Topic Model
class Topic < ActiveRecord::Base
	# Validations
	
	# Relationships
	has_many :posts
end
