# Comment Model
class Comment < ActiveRecord::Base
	# Validations
	validates_presence_of :empathy_level, :text, :user_id, :post_id
	validates_inclusion_of :hidden, :in => [true,false]
	
	# Relationships
	belongs_to :post, :counter_cache => true
	belongs_to :user, :counter_cache => true
end
