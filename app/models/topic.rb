# Topic Model
class Topic < ActiveRecord::Base
  include TagMethods
  
  before_destroy :check_for_posts
  before_save :normalize_input
  
  # Validations
  validates_uniqueness_of :name

  # Relationships
  has_many :posts
end
