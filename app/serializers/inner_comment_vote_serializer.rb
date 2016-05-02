# Inner Comment Vote Serializer
class InnerCommentVoteSerializer < ActiveModel::Serializer
  attributes  :positive_vote,
  # The direct ids used on Voting System filter matching methodology
  # has been choosen due to how complex it can become when attempting
  # to use DS.BelongsTo(). See Ember Data #1865 for more info...
              :user_id,
              :inner_comment_id

  # Relationships
  belongs_to :inner_comment
  belongs_to :user
end
