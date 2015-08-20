class CategorieSerializer < ActiveModel::Serializer
	has_many :posts
	attributes  :id,
				:name,
				:posts_count
end
