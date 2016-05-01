# Inner Comment Vote Serializer
class InnerCommentVoteSerializer < ActiveModel::Serializer
  attributes  :positive_vote

  # Relationships
  belongs_to :inner_comment
  belongs_to :user
end
