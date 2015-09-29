# Post Model
class Post < ActiveRecord::Base
	# Validations
	
	validates :fact_link, presence: true
	validates :fiction_link, presence: true
	validates :title, presence: true
	
	# Relationships
	has_many :comments
	belongs_to :user, :counter_cache => true
	belongs_to :genre, :counter_cache => true
	belongs_to :topic, :counter_cache => true
	belongs_to :fact_type, :counter_cache => true
	belongs_to :category, :counter_cache => true
end
