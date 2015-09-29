# Comment Model
class Comment < ActiveRecord::Base
	# Validations
	
	# Relationships
	belongs_to :post, :counter_cache => true
	belongs_to :user, :counter_cache => true
end
