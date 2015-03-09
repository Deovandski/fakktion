class AdminMessageSerializer < ActiveModel::Serializer
  
  embed :ids, include: true
  
  attributes :id,
             :title,
             :message
end
