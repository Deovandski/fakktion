# InnerCommentVote Model
class InnerCommentVote < ActiveRecord::Base
  
  # Relationships
  belongs_to :inner_comment
  belongs_to :user
end
