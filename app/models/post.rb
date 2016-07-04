# Post Model
class Post < ActiveRecord::Base
  before_create :prevent_tampering
  before_save :normalize_input
  before_destroy :check_for_comments
  # Validations
  validates_presence_of :fact_link, :fiction_link, :text, :title, :user_id, :genre_id, :topic_id, :fact_type_id, :category_id

  # Attributes Length Validations
  validates :title, length: {minimum: 10}
  validates :title, length: {maximum: 100}
  validates :text, length: {minimum: 100}
  validates :text, length: {maximum: 2000}
  validates :fact_link, length: {minimum: 8}
  validates :fact_link, length: {maximum: 150}
  validates :fiction_link, length: {minimum: 8}
  validates :fiction_link, length: {maximum: 150}

  # Relationships
  has_many :comments
  belongs_to :user, :counter_cache => true
  belongs_to :genre, :counter_cache => true
  belongs_to :topic, :counter_cache => true
  belongs_to :fact_type, :counter_cache => true
  belongs_to :category, :counter_cache => true

  private

  # Prevent integer tampering while creating records
  def prevent_tampering
    self.views_count = 0
    self.comments_count = 0
  end

  # Normalize a few attributes to lowercase in case frontend failed to do so.
  def normalize_input
    self.title = title.downcase
    self.fact_link = fact_link.downcase
    self.fiction_link = fiction_link.downcase
  end

  # Allow deletion if there are no comments.
  def check_for_comments
    if self.comments.any?
      errors[:base] << "Cannot Delete! There is at least one comment associated with this post..."
      return false
    end
  end
end
