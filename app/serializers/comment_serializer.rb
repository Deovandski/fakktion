class CommentSerializer < ActiveModel::Serializer
  belongs_to :user
  belongs_to :post
  attributes :id, :soft_delete, :soft_delete_date, :text, :hidden, :empathy_level
end
