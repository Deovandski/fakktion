class AdminMessageSerializer < ActiveModel::Serializer
	ActiveModel::Serializer.config.adapter = :json
	attributes  :id,
				:title,
				:message
end
