class CommentSerializer < ActiveModel::Serializer
	ActiveModel::Serializer.config.adapter = :json
	attributes  :id,
				:soft_delete,
				:soft_delete_date,
				:text,
				:hidden,
				:empathy_level,
				:user_id,
				:post_id
end
