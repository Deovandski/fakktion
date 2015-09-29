# Seeds
case Rails.env
######## Development ENV SEED
	when 'development'
	Rails.logger.info 'seeds.db operating on development mode...'
	# USER RELATED SEED
	Rails.logger.info 'Creating Users'
	if User.count == 0
		# User #1 - Super User:
		User.create!(full_name: 'Sample User',
					show_full_name: true,
					display_name: 'User#1',
					email: 'user@example.com',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'),
					gender: 'male', is_admin: true,
					is_super_user: true,
					facebook_url: '',
					personal_message: 'sample personal message',
					twitter_url: 'https://twitter.com/Deovandski',
					webpage_url: 'www.google.com',
					privacy_terms_read: true,
					legal_terms_read: true)
		# User #2 - Admin User:
		User.create!(full_name: 'User Example',
					show_full_name: true,
					email: 'user@sample.com',
					display_name: 'User#2',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'),
					gender: 'female',
					is_admin: true,
					is_super_user: false,
					facebook_url: '',
					personal_message: 'Vocaloid Rules!',
					twitter_url: 'https://twitter.com/Deo',
					webpage_url: 'www.deovandski.blogspot.com',
					privacy_terms_read: true,
					legal_terms_read: true)
		# User #3 - Normal User:
		User.create!(full_name: 'User',
					show_full_name: true,
					email: 'test@test.com',
					display_name: 'User#3',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'),
					gender: 'male',
					is_admin: false,
					is_super_user: false,
					facebook_url: '',
					personal_message: 'Vocaloid Rules!',
					twitter_url: 'https://twitter.com/Deo',
					webpage_url: 'www.deovandski.blogspot.com',
					privacy_terms_read: true,
					legal_terms_read: true)
		Rails.logger.info 'Users created'
	else
		User.delete_all
		# User #1 - Super User:
		User.create!(full_name: 'Sample User',
					show_full_name: true,
					display_name: 'User#1',
					email: 'user@example.com',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'),
					gender: 'male', is_admin: true,
					is_super_user: true,
					facebook_url: '',
					personal_message: 'sample personal message',
					twitter_url: 'https://twitter.com/Deovandski',
					webpage_url: 'www.google.com',
					privacy_terms_read: true,
					legal_terms_read: true)
		# User #2 - Admin User:
		User.create!(full_name: 'User Example',
					show_full_name: true,
					email: 'user@sample.com',
					display_name: 'User#2',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'),
					gender: 'female',
					is_admin: true,
					is_super_user: false,
					facebook_url: '',
					personal_message: 'Vocaloid Rules!',
					twitter_url: 'https://twitter.com/Deo',
					webpage_url: 'www.deovandski.blogspot.com',
					privacy_terms_read: true,
					legal_terms_read: true)
		# User #3 - Normal User:
		User.create!(full_name: 'User',
					show_full_name: true,
					email: 'test@test.com',
					display_name: 'User#3',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'),
					gender: 'male',
					is_admin: false,
					is_super_user: false,
					facebook_url: '',
					personal_message: 'Vocaloid Rules!',
					twitter_url: 'https://twitter.com/Deo',
					webpage_url: 'www.deovandski.blogspot.com',
					privacy_terms_read: true,
					legal_terms_read: true)
	Rails.logger.info 'All current users deleted and created again from seed file.'
	end

	# CATEGORIES RELATED SEED
	Rails.logger.info 'Creating Categories'
	if Category.count == 0
		Category.create!(name: 'A-B-C')
		Category.create!(name: 'D-E-F')
		Category.create!(name: 'G-H-I')
		Category.create!(name: 'J-K-L')
		Category.create!(name: 'M-N-O')
		Category.create!(name: 'P-Q-R')
		Category.create!(name: 'S-T-U')
		Category.create!(name: 'V-W-X')
		Category.create!(name: 'Y-Z-?')
		Rails.logger.info 'Categories created'
	else
		Category.delete_all
		Category.create!(name: 'A-B-C')
		Category.create!(name: 'D-E-F')
		Category.create!(name: 'G-H-I')
		Category.create!(name: 'J-K-L')
		Category.create!(name: 'M-N-O')
		Category.create!(name: 'P-Q-R')
		Category.create!(name: 'S-T-U')
		Category.create!(name: 'V-W-X')
		Category.create!(name: 'Y-Z-?')
		Rails.logger.info 'All current Categories deleted and created again from seed file.'
	end

	# FACT TYPE RELATED SEED
	Rails.logger.info 'Creating fact types'
	if FactType.count == 0
		FactType.create!(name: 'Business')
		FactType.create!(name: 'Technology')
		FactType.create!(name: 'International')
		Rails.logger.info 'Fact types created'
	else
		FactType.delete_all
		FactType.create!(name: 'Business')
		FactType.create!(name: 'Technology')
		FactType.create!(name: 'International')
		Rails.logger.info 'All current fact types deleted and created again from seed file.'
	end

	# GENRE RELATED SEED
	Rails.logger.info 'Creating Genres'
	if Genre.count == 0
		Genre.create!(name: 'Song')
		Genre.create!(name: 'Novel')
		Genre.create!(name: 'Movie')
		Rails.logger.info 'Genres created'
	else
		Genre.delete_all
		Genre.create!(name: 'Song')
		Genre.create!(name: 'Novel')
		Genre.create!(name: 'Movie')
		Rails.logger.info 'All current genres deleted and created again from seed file.'
	end

	# TOPIC RELATED SEED
	Rails.logger.info 'Creating topics'
	if Topic.count == 0
		Topic.create!(name: 'hatsune miku')
		Topic.create!(name: 'megurine luka')
		Rails.logger.info 'Topics created'
	else
		Topic.delete_all
		Topic.create!(name: 'hatsune miku')
		Topic.create!(name: 'megurine luka')
		Rails.logger.info 'All current topics deleted and created again from seed file.'
	end

	# POST RELATED SEED
	Rails.logger.info 'Creating posts'
	if Post.count == 0
		Post.create!(fact_link: 'test fact link',
					fact_type_id: 1,
					fiction_link: 'test fiction link',
					text: 'Miku is love! Miku is Life! No seriously, Miku is the result of how community driven creativity can bring a virtual being into life.',
					genre_id: 1,
					hidden: false,
					importance: 0,
					title: 'The concept of reality behind Hatsune Miku',
					soft_delete: false,
					soft_delete_date: nil,
					topic_id: 1,
					user_id: 0,
					category_id: 2)
		Post.create!(fact_link: 'test fact link',
					fact_type_id: 2,
					fiction_link: 'test fiction link',
					text: 'test Text',
					genre_id: 2,
					hidden: false, 
					importance: 0,
					title: 'test Novel Post with category D-E-F', 
					soft_delete: false,
					soft_delete_date: nil,
					topic_id: 1,
					user_id: 0,
					category_id: 1)
		Post.create!(fact_link: 'test fact link #2',
					fact_type_id: 1,
					fiction_link: 'test fiction link #2',
					text: 'test Text #2',
					genre_id: 3,
					hidden: false,
					importance: 0,
					title: 'test Novel Post with category G-H-I',
					soft_delete: false,
					soft_delete_date: nil,
					topic_id: 1,
					user_id: 0,
					category_id: 3)
		Rails.logger.info 'Posts created'
	else
		Post.create!(fact_link: 'test fact link',
					fact_type_id: 1,
					fiction_link: 'test fiction link',
					text: 'Miku is love! Miku is Life! No seriously, Miku is the result of how community driven creativity can bring a virtual being into life.',
					genre_id: 1,
					hidden: false,
					importance: 0,
					title: 'The concept of reality behind Hatsune Miku',
					soft_delete: false,
					soft_delete_date: nil,
					topic_id: 1,
					user_id: 0,
					category_id: 2)
		Post.create!(fact_link: 'test fact link',
					fact_type_id: 2,
					fiction_link: 'test fiction link',
					text: 'test Text',
					genre_id: 2,
					hidden: false, 
					importance: 0,
					title: 'test Novel Post with category D-E-F', 
					soft_delete: false,
					soft_delete_date: nil,
					topic_id: 1,
					user_id: 0,
					category_id: 1)
		Post.create!(fact_link: 'test fact link #2',
					fact_type_id: 1,
					fiction_link: 'test fiction link #2',
					text: 'test Text #2',
					genre_id: 3,
					hidden: false,
					importance: 0,
					title: 'test Novel Post with category G-H-I',
					soft_delete: false,
					soft_delete_date: nil,
					topic_id: 1,
					user_id: 0,
					category_id: 3)
		Rails.logger.info 'Posts created'
		Rails.logger.info 'All current posts deleted and created again from seed file.'
	end

	# COMMENTS RELATED SEED
	Rails.logger.info 'Creating Comments'
	if Comment.count == 0
		Comment.create!(hidden: false,
						post_id: 1,
						soft_delete: false,
						soft_delete_date: nil,
						text: 'Sample Text #1',
						user_id: 1,
						empathy_level: 0)
		Comment.create!(hidden: false,
						post_id: 0,
						soft_delete: false,
						soft_delete_date: nil,
						text: 'Sample Text',
						user_id: 0,
						empathy_level: 0)
		Rails.logger.info 'Comments created'
	else
		Comment.create!(hidden: false,
						post_id: 2,
						soft_delete: false,
						soft_delete_date: nil,
						text: 'Sample Text #1',
						user_id: 1,
						empathy_level: 0)
		Comment.create!(hidden: false,
						post_id: 1,
						soft_delete: false,
						soft_delete_date: nil,
						text: 'Sample Text #2 by Admin',
						user_id: 0,
						empathy_level: 0)
		Rails.logger.info 'All current comments deleted and created again from seed file.'
	end

	# ADMIN MESSAGES RELATED SEED
	Rails.logger.info 'Creating admin messages'
	if AdminMessage.count == 0
		AdminMessage.create!(title: 'Welcome Message',
							message: 'Welcome to Fakktion! This is the first Admin Message',
							user_id: 0)
		Rails.logger.info 'Admin messages created'
	else
		AdminMessage.create!(title: 'Welcome Message',
							message: 'Welcome to Fakktion! This is the first Admin Message',
							user_id: 0)
		Rails.logger.info 'All current admin messages deleted and created again from seed file.'
	end

	Rails.logger.info 'seeding on development ENV ended...'
######## Test ENV SEED
when 'test'
	Rails.logger.info 'seeds.db operating on test mode...'
	# TODO
	Rails.logger.info 'seeding on test ENV ended...'

######## Production ENV SEED
when 'production'
	Rails.logger.info 'seeds.db operating on production mode...'
	# TODO
	Rails.logger.info 'seeding on production ENV ended...'
end
