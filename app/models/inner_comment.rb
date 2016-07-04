# Comment Model
class InnerComment < ActiveRecord::Base
  before_create :prevent_tampering
  before_destroy :check_empathy
  # Validations
  validates_presence_of :empathy_level, :text, :user_id, :comment_id

  # Attributes Length Validations
  validates :text, length: {minimum: 25}
  validates :text, length: {maximum: 500}

  # Relationships
  belongs_to :comment, :counter_cache => true
  belongs_to :user

  private

  # Prevent integer tampering while creating records
  def prevent_tampering
    self.empathy_level = 0
  end

  # Allow deletion if the inner_comment empathy level is lower than -10.
  def check_empathy
    if self.empathy_level < -10
      errors[:base] << "Empathy Level is not lower than -10"
      return false
    end
  end
end
