class FactTypeSerializer < ActiveModel::Serializer
	has_many :posts
	attributes  :id,
				:name,
				:usage_count
end
