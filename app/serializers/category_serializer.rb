class CategorySerializer < ActiveModel::Serializer
	attributes  :name,
				:posts_count
				
	has_many :posts
end
