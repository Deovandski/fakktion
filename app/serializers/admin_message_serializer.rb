# Admin Message Serializer
class AdminMessageSerializer < ActiveModel::Serializer
	attributes  :title,
				:message
	
	# Relationships
	belongs_to :user
end
