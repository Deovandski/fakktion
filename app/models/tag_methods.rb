# Shared Tag Models
module TagMethods

  protected
  
  # Normalize :name to lowercase in case frontend failed to do so.
  def normalize_input
    self.name = name.downcase
  end
  
  def set_default_values
    self.eligibility_counter = 0
    self.posts_count = 0
  end
  # Make sure that there are no posts using this tag before destruction.
  def check_for_posts
    if self.posts.any?
      errors[:base] << "cannot delete Topic tag when posts are using it!"
      return false
    end
  end
end
