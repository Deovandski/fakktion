# Shared Tag Models
module TagMethods

  protected
  
  # Normalize :name to lowercase in case frontend failed to do so.
  def normalize_input
    self.name = name.downcase
  end
  
  # Make sure that there are no posts using this tag before destruction.
  def check_for_posts
    if self.posts.any?
      errors[:base] << "cannot delete Topic tag when posts are using it!"
      return false
    end
  end
end
