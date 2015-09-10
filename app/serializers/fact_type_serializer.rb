class FactTypeSerializer < ActiveModel::Serializer
	attributes  :name,
				:eligibility_counter,
				:posts_count
						
	has_many :posts
end
