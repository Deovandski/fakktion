import DS from "ember-data";

export default DS.Model.extend ({
	full_name: DS.attr ('string'),
	display_name: DS.attr ('string'),
	password: DS.attr ('string'),
	email: DS.attr ('string'),
	date_of_birth: DS.attr ('date'),
	gender: DS.attr ('string'),
	facebook_url: DS.attr ('string'),
	twitter_url: DS.attr ('string'),
	personal_message: DS.attr ('string'),
	webpage_url: DS.attr ('string'),
	is_banned: DS.attr ('boolean'),
	is_banned_date: DS.attr ('date'),
	legal_terms_read: DS.attr ('boolean'),
	privacy_terms_read: DS.attr ('boolean'),
	is_admin: DS.attr ('boolean'),
	is_super_user: DS.attr ('boolean'),
	sign_in_count: DS.attr ('number'),
	last_sign_in_at: DS.attr ('date'),
	updated_at: DS.attr ('date'),
	created_at: DS.attr ('date'),
	show_full_name: DS.attr ('boolean'),
	admin_messages_count: DS.attr ('number'),
	posts_count: DS.attr ('number'),
	comments_count: DS.attr ('number'),
	times_banned: DS.attr ('number'),
	
	// Relationships
	admin_messages: DS.hasMany('admin_message', {async: true}),
	posts: DS.hasMany('post', {async: true}),
	comments: DS.hasMany('comment', {async: true})
});
