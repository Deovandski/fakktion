# Topic Serializer
class TopicSerializer < ActiveModel::Serializer
  attributes  :name,
              :eligibility_counter,
              :posts_count

  # Relationships
  has_many :posts
end
