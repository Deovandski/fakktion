# CommentVote Model
class CommentVote < ActiveRecord::Base
  before_destroy :prevent_destroy

  # Relationships
  belongs_to :comment
  belongs_to :user

  private
  def prevent_destroy
    false
  end
end
