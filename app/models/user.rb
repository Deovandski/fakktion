require 'bcrypt'
class User < ActiveRecord::Base
  has_many :admin_messages
  has_many :posts
  has_many :comments

  # users.password_hash in the database is a :string
  include BCrypt
  has_secure_password
  validates :gender, presence: true
  validates :password, length: { minimum: 8 }
  validates_presence_of :full_name, :email, :display_name, :date_of_birth
  validates_uniqueness_of :email
  validates_acceptance_of :privacy_terms_read, :on => :create, :accept => true, :allow_nil => false
  validates_acceptance_of :legal_terms_read, :on => :create, :accept => true, :allow_nil => false
  enum gender: { male: 0, female: 1, other: 2 }
end
