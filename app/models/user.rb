# User Model
require 'bcrypt'
class User < ActiveRecord::Base
	before_save :ensure_authentication_token, :normalize_input
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	# users.password_hash in the database is a :string
	include BCrypt
	devise :database_authenticatable, :registerable,
		 :recoverable, :rememberable, :trackable, :validatable

	# Validations
	validates :password, presence: true, length: { minimum: 8 }, on: :create
	validates :password, length: {minimum: 8}, on: :update, allow_blank: true
	validates_presence_of :full_name, :show_full_name, :email, :display_name, :date_of_birth, :gender
	validates_inclusion_of :is_banned, :is_admin, :in => [true,false]
	validates_uniqueness_of :email, :display_name
	validates_acceptance_of :privacy_terms_read, :on => :create, :accept => true, :allow_nil => false
	validates_acceptance_of :legal_terms_read, :on => :create, :accept => true, :allow_nil => false
	enum gender: { male: 0, female: 1, other: 2 }
	
	# Relationships
	has_many :admin_messages
	has_many :posts
	has_many :comments
	has_many :inner_comments

	def ensure_authentication_token
		if authentication_token.blank?
			self.authentication_token = generate_authentication_token
		end
	end

	private

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
end
