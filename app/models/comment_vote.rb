# CommentVote Model
class CommentVote < ActiveRecord::Base
  
  # Relationships
  belongs_to :comment
  belongs_to :user
end
