# Comment Model
class Comment < ActiveRecord::Base
  before_destroy :check_for_inner_comments
  
  # Validations
  validates_presence_of :empathy_level, :text, :user_id, :post_id
  
  # Attributes Length Validations
  validates :text, length: {minimum: 25}
  validates :text, length: {maximum: 1000}

  # Relationships
  has_many :inner_comments
  belongs_to :post, :counter_cache => true
  belongs_to :user, :counter_cache => true
  
  # Make sure that there are no Inner Comments associated before destruction.
  def check_for_inner_comments
    if self.inner_comments.any?
      errors[:base] << "cannot delete Comment when there are inner Comments associated!"
      return false
    end
  end
end
