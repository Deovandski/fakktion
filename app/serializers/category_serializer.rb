# Category Serializer
class CategorySerializer < ActiveModel::Serializer
	attributes  :name,
				:posts_count

	# Relationships
	has_many :posts
end
