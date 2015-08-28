class CategorySerializer < ActiveModel::Serializer
	has_many :posts
	attributes  :id,
				:name,
				:posts_count
end
