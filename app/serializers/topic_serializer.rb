class TopicSerializer < ActiveModel::Serializer
	has_many :posts
	attributes  :id,
				:name,
				:eligibility_counter,
				:posts_count
end

