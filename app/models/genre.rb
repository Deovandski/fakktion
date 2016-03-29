# Genre Model
class Genre < ActiveRecord::Base
  include TagMethods
  
  before_create :set_default_values
  before_save :normalize_input
  before_destroy :check_for_posts
  
  # Validations
  validates_uniqueness_of :name
  
  # Relationships
  has_many :posts
end
