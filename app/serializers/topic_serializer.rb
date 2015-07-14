class TopicSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
				 :usage_count
end

