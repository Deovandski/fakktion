class FactTypeSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
				 :usage_count
end
