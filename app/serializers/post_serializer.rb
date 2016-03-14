# Post Serializer
class PostSerializer < ActiveModel::Serializer
	attributes  :fact_link,
				:fiction_link,
				:title,
				:importance,
				:hidden,
				:views_count,
				:text,
				:comments_count,
				:created_at,
				:updated_at,
				
				# For index filter purpose... May changed on beta or v1 release as dependencies are updated.
				:genre_id,
				:category_id,
				:topic_id,
				:fact_type_id,
				:user_id

	# Relationships
	has_many :comments
	belongs_to :genre
	belongs_to :fact_type
	belongs_to :category
	belongs_to :topic
	belongs_to :user
end
