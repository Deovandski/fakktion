# Admin Message Model
class AdminMessage < ActiveRecord::Base
  before_save :normalize_input

  # Validations
  validates_presence_of :message, :title, :user_id
  validates_uniqueness_of :title

  # Relationships
  belongs_to :user, :counter_cache => true

  private
  
  # Normalize :title to lowercase in case frontend failed to do so.
  def normalize_input
    self.title = title.downcase
  end
end
