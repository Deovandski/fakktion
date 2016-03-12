# Comment Model
class InnerComment < ActiveRecord::Base
	# Validations
	validates_presence_of :empathy_level, :text, :user_id, :comment_id
	validates_inclusion_of :hidden, :in => [true,false]
	
	# Relationships
	belongs_to :comment, :counter_cache => true
	belongs_to :user
end
