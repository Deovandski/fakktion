# Fact Type Model
class FactType < ActiveRecord::Base
	# Validations
	
	# Relationships
	has_many :posts
end
