# Comment Serializer
class CommentSerializer < ActiveModel::Serializer
  attributes  :text,
              :hidden,
              :empathy_level,
              :created_at,
              :updated_at

  # Relationships
  has_many :inner_comments
  belongs_to :post
  belongs_to :user
end
