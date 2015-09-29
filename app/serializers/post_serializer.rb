# Post Serializer
class PostSerializer < ActiveModel::Serializer
	attributes  :fact_link,
				:fiction_link,
				:title,
				:importance, 
				:soft_delete,
				:soft_delete_date,
				:hidden,
				:views_count,
				:text,
				:comments_count,
				:created_at,
				:updated_at

	# Relationships
	has_many :comments
	belongs_to :genre
	belongs_to :fact_type
	belongs_to :category
	belongs_to :topic
	belongs_to :user
end
