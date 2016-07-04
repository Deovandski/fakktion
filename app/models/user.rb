# User Model
require 'bcrypt'
# All validations and Actve Record for User
class User < ActiveRecord::Base
  before_create :prevent_tampering
  before_save :ensure_authentication_token, :normalize_input
  before_destroy :check_for_resources
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # users.password_hash in the database is a :string
  include BCrypt
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # For use alongside tests.
  attr_accessor :current_password

  # Validations
  validates_presence_of :full_name, :show_full_name, :email, :display_name, :date_of_birth
  validates_inclusion_of :is_super_user, :is_admin, :is_legend, :in => [true,false]
  validates_uniqueness_of :email, :display_name
  validates_acceptance_of :privacy_terms_read, :on => :create, :accept => true, :allow_nil => false
  validates_acceptance_of :legal_terms_read, :on => :create, :accept => true, :allow_nil => false

  # Attributes Length Validations
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :password, presence: true, length: { maximum: 72 }, on: :create
  validates :password, length: {minimum: 8}, on: :update, allow_blank: true
  validates :password, length: {maximum: 72}, on: :update, allow_blank: true
  validates :full_name, length: {minimum: 5}
  validates :full_name, length: {maximum: 30}
  validates :display_name, length: {minimum: 3}
  validates :display_name, length: {maximum: 15}
  validates :email, length: {minimum: 4}
  validates :email, length: {maximum: 30}
  validates :webpage_url, length: {minimum: 0}
  validates :webpage_url, length: {maximum: 40}
  validates :facebook_url, length: {minimum: 0}
  validates :facebook_url, length: {maximum: 40}
  validates :twitter_url, length: {minimum: 0}
  validates :twitter_url, length: {maximum: 40}
  validates :personal_message, length: {maximum: 100}

  # Relationships
  has_many :admin_messages
  has_many :posts
  has_many :comments
  has_many :inner_comments

  # Used when creating users
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private
  
  # Prevent integer tampering while creating records
  def prevent_tampering
    self.is_super_user = false
    self.is_admin = false
    self.is_legend = false
    self.comments_count = 0
    self.posts_count = 0
    self.reputation = 0
  end

  # Generate token.
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
  
  # Normalize a few attributes to lowercase in case frontend failed to do so.
  def normalize_input
    self.email = email.downcase
    self.display_name = display_name.downcase
    self.full_name = full_name.downcase
  end
  
  # Make sure that there are no resources created by this user
  def check_for_resources
    if self.posts.any?
      errors[:base] << "Cannot delete account! You have at least one post associated to it."
      return false
    end
    if self.comments.any?
      errors[:base] << "Cannot delete account! You have at least one comment associated to it."
      return false
    end
    if self.inner_comments.any?
      errors[:base] << "Cannot delete account! You have at least one inner comment associated to it."
      return false
    end
  end
end
