# Comment Vote Serializer
class CommentVoteSerializer < ActiveModel::Serializer
  attributes  :positive_vote

  # Relationships
  belongs_to :comment
  belongs_to :user
end
