# Comment Model
class InnerComment < ActiveRecord::Base
  before_destroy :check_empathy
  # Validations
  validates_presence_of :empathy_level, :text, :user_id, :comment_id
  validates_inclusion_of :hidden, :in => [true,false]

  # Relationships
  belongs_to :comment, :counter_cache => true
  belongs_to :user
  
  # Allow deletion if the inner_comment empathy level is lower than -10.
  def check_empathy
    if self.empathy_level < -10
      errors[:base] << "Empathy Level is not lower than -10"
      return false
    end
  end
end
