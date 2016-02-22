# Category Model
class Category < ActiveRecord::Base
	# Validations
	validates_uniqueness_of :name
	
	# Relationships
	has_many :posts
end
