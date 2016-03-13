# User Serializer
class UserSerializer < ActiveModel::Serializer
	attributes  :full_name,
				:display_name,
				:email,
				:date_of_birth,
				:gender,
				:facebook_url,
				:twitter_url,
				:personal_message,
				:webpage_url,
				:is_banned,
				:is_banned_date,
				:times_banned,
				:legal_terms_read,
				:privacy_terms_read,
				:is_admin,
				:sign_in_count,
				:current_password,
				:password,
				:last_sign_in_at,
				:created_at,
				:updated_at,
				:show_full_name,
				:posts_count,
				:admin_messages_count,
				:comments_count,
				:authentication_token

	# Relationships
	has_many	:posts
	has_many	:comments
	has_many	:inner_comments
	has_many	:admin_messages
end
