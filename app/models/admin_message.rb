# Admin Message Model
class AdminMessage < ActiveRecord::Base
	# Validations
	validates :title, presence: true
	validates :message, presence: true
	
	# Relationships
	belongs_to :user, :counter_cache => true
end
