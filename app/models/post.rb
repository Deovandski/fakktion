# Post Model
class Post < ActiveRecord::Base
	before_save :normalize_input
	# Validations
	validates_presence_of :fact_link, :fiction_link, :text, :title, :user_id, :genre_id, :topic_id, :fact_type_id, :category_id
	validates_inclusion_of :hidden, :in => [true,false]
	
	# Relationships
	has_many :comments
	belongs_to :user, :counter_cache => true
	belongs_to :genre, :counter_cache => true
	belongs_to :topic, :counter_cache => true
	belongs_to :fact_type, :counter_cache => true
	belongs_to :category, :counter_cache => true
	
	# Normalize a few attributes to lowercase in case frontend failed to do so.
	def normalize_input
		self.title = title.downcase
	end
end
