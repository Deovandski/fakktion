class FactTypeSerializer < ActiveModel::Serializer
	ActiveModel::Serializer.config.adapter = :json
	has_many :posts
	attributes  :id,
				:name,
				:eligibility_counter,
				:posts_count
end
