class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :full_name,
             :display_name,
             :email,
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
             :is_admin,
             :is_super_user,
             :sign_in_count
end
