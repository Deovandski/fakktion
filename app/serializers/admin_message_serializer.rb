class AdminMessageSerializer < ActiveModel::Serializer
	attributes  :title,
				:message
				
	belongs_to :user
end
