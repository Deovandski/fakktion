# Comment Serializer
class CommentSerializer < ActiveModel::Serializer
	attributes  :text,
				:hidden,
				:empathy_level

	# Relationships
	belongs_to :post
	belongs_to :user
end
