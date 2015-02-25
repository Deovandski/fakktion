class TopicSerializer < ActiveModel::Serializer
  has_many :posts
  attributes :id, :topic_name
end
