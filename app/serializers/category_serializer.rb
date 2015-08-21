class CategorySerializer < ActiveModel::Serializer
	ActiveModel::Serializer.config.adapter = :json
	has_many :posts
	attributes  :id,
				:name,
				:posts_count
end
