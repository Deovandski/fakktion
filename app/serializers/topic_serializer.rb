class TopicSerializer < ActiveModel::Serializer
  #has_many :posts
  
  embed :ids, include: true
  
  attributes :id,
             :topic_name
end
