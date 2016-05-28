# Inner Comment Serializer
class InnerCommentSerializer < ActiveModel::Serializer
  attributes  :text,
              :hidden,
              :empathy_level,
              :created_at,
              :updated_at

  # Relationships
  belongs_to :comment
  belongs_to :user
end
