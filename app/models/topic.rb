# Topic Model
class Topic < ActiveRecord::Base
	before_save :normalize_input
	
	# Validations
	validates_uniqueness_of :name
	
	# Relationships
	has_many :posts
	
	# Normalize :name to lowercase in case frontend failed to do so.
	def normalize_input
		self.name = name.downcase
	end
end
