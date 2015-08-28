class PostSerializer < ActiveModel::Serializer
	has_many :comments
	belongs_to :genre
	belongs_to :fact_type
	belongs_to :category
	belongs_to :topic
	attributes  :id,
				:user_id,
				:genre_id,
				:topic_id,
				:category_id,
				:fact_type_id,
				:fact_link,
				:fiction_link,
				:title,
				:importance, 
				:soft_delete,
				:soft_delete_date,
				:hidden,
				:views_count,
				:text,
				:comments_count
end
