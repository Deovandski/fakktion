require 'bcrypt'
class User < ActiveRecord::Base
	before_save :ensure_authentication_token
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	# users.password_hash in the database is a :string
	include BCrypt
	devise :database_authenticatable, :registerable,
		 :recoverable, :rememberable, :trackable, :validatable
		 
	has_many :admin_messages
	has_many :posts
	has_many :comments

	validates :gender, presence: true
	validates :password, presence: true, length: { minimum: 8 }, on: :create
	validates :password, length: {minimum: 8}, on: :update, allow_blank: true
	validates_presence_of :full_name, :email, :display_name, :date_of_birth
	validates_uniqueness_of :email, :display_name
	validates_acceptance_of :privacy_terms_read, :on => :create, :accept => true, :allow_nil => false
	validates_acceptance_of :legal_terms_read, :on => :create, :accept => true, :allow_nil => false
	enum gender: { male: 0, female: 1, other: 2 }

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
end
