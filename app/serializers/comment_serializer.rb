# Comment Serializer
class CommentSerializer < ActiveModel::Serializer
	attributes  :text,
				:hidden,
				:empathy_level

	# Relationships
	has_many :inner_comments
	belongs_to :post
	belongs_to :user
end
