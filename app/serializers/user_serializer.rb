class UserSerializer < ActiveModel::Serializer
  has_many :posts
  has_many :comments
  has_many :admin_messages
  embed :ids, include: true
  attributes :id,
             :full_name,
             :display_name,
             :email,
             :password_digest,
             :date_of_birth,
             :gender,
             :facebook_id,
             :twitter_url,
             :personal_message,
             :webpage_url,
             :is_banned,
             :is_banned_date,
             :number_of_posts,
             :number_of_comments,
             :legal_terms_read,
             :privacy_terms_read,
             :is_admin
end
