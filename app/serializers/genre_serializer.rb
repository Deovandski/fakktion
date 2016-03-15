# Genre Serializer
class GenreSerializer < ActiveModel::Serializer
  attributes  :name,
              :eligibility_counter,
              :posts_count

  # Relationships
  has_many :posts
end
