# Fact Type Model
class FactType < ActiveRecord::Base
  before_destroy :check_for_posts
  before_save :normalize_input
  
  # Validations
  validates_uniqueness_of :name

  # Relationships
  has_many :posts
  
  private
  
  # Normalize :name to lowercase in case frontend failed to do so.
  def normalize_input
    self.name = name.downcase
  end
  
  # Make sure that there are no posts using this tag before destruction.
  def check_for_posts
    if self.posts.any?
      errors[:base] << "cannot delete Fact Type tag when posts are using it!"
      return false
    end
  end
end
