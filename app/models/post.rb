class Post < ActiveRecord::Base
	validates :fact_link, presence: true
	validates :fiction_link, presence: true
	validates :title, presence: true

	has_many :comments
	belongs_to :user
	belongs_to :genre
	belongs_to :topic
	belongs_to :fact_type
end
