class AdminMessageSerializer < ActiveModel::Serializer
  belongs_to :user
  
  embed :ids, include: true
  
  attributes :id,
             :title,
             :message
end
