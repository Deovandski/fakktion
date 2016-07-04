# Genre Model
class Genre < ActiveRecord::Base
  include TagMethods

  before_create :set_default_values
  before_destroy :check_for_posts
  before_save :normalize_input

  # Validations
  validates_uniqueness_of :name

  # Attributes Length Validations
  validates :name, length: {minimum: 4}
  validates :name, length: {maximum: 15}

  # Relationships
  has_many :posts
end
