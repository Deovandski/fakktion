# Comment Serializer
class CommentSerializer < ActiveModel::Serializer
	attributes  :soft_delete,
				:soft_delete_date,
				:text,
				:hidden,
				:empathy_level

	# Relationships
	belongs_to :post
	belongs_to :user
end
