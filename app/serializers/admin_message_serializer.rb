class AdminMessageSerializer < ActiveModel::Serializer
	ActiveModel::Serializer.config.adapter = :json
	belongs_to :user
	attributes  :id,
				:title,
				:message
end
