# InnerCommentVote Model
class InnerCommentVote < ActiveRecord::Base
  before_destroy :prevent_destroy
  
  # Relationships
  belongs_to :inner_comment
  belongs_to :user
  
  private
  def prevent_destroy
    false
  end
end
