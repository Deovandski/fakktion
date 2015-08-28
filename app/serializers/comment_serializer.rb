class CommentSerializer < ActiveModel::Serializer
	belongs_to :post
	attributes  :id,
				:soft_delete,
				:soft_delete_date,
				:text,
				:hidden,
				:empathy_level,
				:user_id,
				:post_id
end
