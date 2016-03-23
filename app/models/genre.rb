# Genre Model
class Genre < ActiveRecord::Base
  before_save :normalize_input
  before_destroy :check_for_posts
  
  # Validations
  validates_uniqueness_of :name
  
  # Relationships
  has_many :posts
  
  private
  
  # Normalize :name to lowercase in case frontend failed to do so.
  def normalize_input
    self.name = name.downcase
  end
  
  # Make sure that there are no posts using the tag before destruction.
  def check_for_posts
    puts self.posts_count
    if self.posts.any?
      errors[:base] << "cannot delete Genre tag when posts are using it!"
      return false
    end
  end
end
