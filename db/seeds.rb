# Seeds
case Rails.env

################ Development ENV SEED ################

	when 'development'
		Rails.logger.info 'seeds.db operating on development mode...'

		# USER RELATED SEED
		if User.count != 0
			User.delete_all
			Rails.logger.info 'All previous users deleted....'
		end
		# User #1 - Super User:
		User.create!(full_name: 'Sample User',
					show_full_name: true,
					display_name: 'User#1',
					email: 'user@example.com',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2001', '%m/%d/%Y'),
					gender: 'male',
					is_admin: true,
					is_super_user: true,
					is_banned: false,
					facebook_url: '',
					personal_message: 'sample personal message',
					twitter_url: 'https://twitter.com/Deovandski',
					webpage_url: 'https://www.google.com',
					privacy_terms_read: true,
					legal_terms_read: true)
		# User #2 - Admin User:
		User.create!(full_name: 'User Example',
					show_full_name: true,
					email: 'user@sample.com',
					display_name: 'User#2',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2002', '%m/%d/%Y'),
					gender: 'female',
					is_admin: true,
					is_super_user: false,
					is_banned: false,
					facebook_url: '',
					personal_message: 'Vocaloid Rules!',
					twitter_url: 'https://twitter.com/Deo',
					webpage_url: 'https://www.deovandski.blogspot.com',
					privacy_terms_read: true,
					legal_terms_read: true)
		# User #3 - Normal User:
		User.create!(full_name: 'User',
					show_full_name: true,
					email: 'test@test.com',
					display_name: 'User#3',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2003', '%m/%d/%Y'),
					gender: 'male',
					is_admin: false,
					is_super_user: false,
					is_banned: false,
					facebook_url: '',
					personal_message: 'Vocaloid Rules!',
					twitter_url: 'https://twitter.com/Deo',
					webpage_url: 'http://deovandski.heroku.com/',
					privacy_terms_read: true,
					legal_terms_read: true)
		Rails.logger.info 'Default users created!'

		# CATEGORIES RELATED SEED
		if Category.count != 0
			Category.delete_all
			Rails.logger.info 'All previous categories deleted...'
		end
		Category.create!(name: 'A-B-C') # ID 1
		Category.create!(name: 'D-E-F') # ID 2
		Category.create!(name: 'G-H-I') # ID 3
		Category.create!(name: 'J-K-L') # ID 4
		Category.create!(name: 'M-N-O') # ID 5
		Category.create!(name: 'P-Q-R') # ID 6
		Category.create!(name: 'S-T-U') # ID 7
		Category.create!(name: 'V-W-X') # ID 8
		Category.create!(name: 'Y-Z-?') # ID 9
		Rails.logger.info 'Default categories created!'

		# FACT TYPE RELATED SEED
		if FactType.count != 0
			FactType.delete_all
			Rails.logger.info 'All previous fact types deleted...'
		end
		FactType.create!(name: 'Business') # ID 1
		FactType.create!(name: 'Technology') # ID 2
		FactType.create!(name: 'International') # ID 3
		Rails.logger.info 'Default fact types created!'

		# GENRE RELATED SEED
		if Genre.count != 0
			Genre.delete_all
			Rails.logger.info 'All previous genres deleted...'
		end
		Genre.create!(name: 'Song') # ID 1
		Genre.create!(name: 'Novel') # ID 2
		Genre.create!(name: 'Movie') # ID 3
		Rails.logger.info 'Default genres created!'

		# TOPIC RELATED SEED
		if Topic.count != 0
			Topic.delete_all
			Rails.logger.info 'All previous topics deleted...'
		end
		Topic.create!(name: 'hatsune miku') # ID 1
		Topic.create!(name: 'megurine luka') # ID 2
		Rails.logger.info 'Default topics created!'

		# POST RELATED SEED
		if Post.count != 0
			Post.delete_all
			Rails.logger.info 'All previous posts deleted...'
		end
		Post.create!(fact_link: 'https://en.wikipedia.org/wiki/Hatsune_Miku',
					fiction_link: 'http://www.cbsnews.com/news/hatsune-miku-the-worlds-fakest-pop-star/',
					text: 'Miku is love! Miku is Life! No seriously, Miku is the result of how community driven creativity can bring a virtual being into real life. The Fiction article talks about Miku being a fake persona or a simple program, but if you ask the Vocaloid community, you will hear quite the different tale. Miku is not the only Vocaloid, but she is the logo of how community driven content management can not only bring people closer, but also breath life into a character that represents most of the Vocaloid community (as in all the people who have respect for her in an I-thou interpersonal relation.)',
					importance: 10,
					title: 'The concept of reality behind Hatsune Miku',
					hidden: false,
					genre_id: 1,
					fact_type_id: 2,
					topic_id: 1,
					user_id: 1,
					category_id: 3)
		Post.create!(fact_link: 'https://www.google.com',
					fact_type_id: 3,
					fiction_link: 'https://www.google.com',
					text: 'test Text',
					genre_id: 2,
					hidden: false, 
					importance: 0,
					title: 'International Novel Post with category D-E-F and topic Megurine Luka', 
					topic_id: 2,
					user_id: 1,
					category_id: 2)
		Post.create!(fact_link: 'https://www.google.com',
					fact_type_id: 1,
					fiction_link: 'https://www.google.com',
					text: 'test Text #2',
					genre_id: 3,
					hidden: false,
					importance: 0,
					title: 'Business Movie Post with category G-H-I and Megurine Luka topic',
					topic_id: 2,
					user_id: 2,
					category_id: 3)
		Rails.logger.info 'Default posts created!'

		# COMMENTS RELATED SEED

		if Comment.count == 0
			Comment.delete_all
			Rails.logger.info 'All previous comments deleted...'
		end
		Comment.create!(hidden: false,
						post_id: 1,
						text: 'Sample Text',
						user_id: 1,
						empathy_level: 0)
		Comment.create!(hidden: false,
						post_id: 2,
						text: 'Sample Text #1',
						user_id: 2,
						empathy_level: 0)
		Comment.create!(hidden: false,
						post_id: 1,
						text: 'Sample Text #1',
						user_id: 2,
						empathy_level: 0)
		Rails.logger.info 'Default comments created!'

		# ADMIN MESSAGES RELATED SEED

		if AdminMessage.count != 0
			AdminMessage.delete_all
			Rails.logger.info 'All previous admin messages deleted.'
		end
		AdminMessage.create!(title: 'Welcome to Fakktion Experimental!',
							message: 'Check Github for progress and Active Model Serializers #1238 for Deserialization. 
							Please use a unique password and if possible dummy data like random birthdates, display names and full name.
							Recommendations or if you just want to stop by to say hi, please contact me on Twitter or Github.',
							user_id: 1)
		Rails.logger.info 'Default admin messages created'
		
		Rails.logger.info 'seeding on development ENV ended...'

################ Test ENV SEED ################

	when 'test'
		Rails.logger.info 'seeds.db operating on test mode...'

		# Use Fixtures located on Test/Fixtures...
		Rails.logger.info 'Use Fixtures located on Test/Fixtures...'

		Rails.logger.info 'seeding on test ENV ended...'

################ Production ENV SEED ################

	when 'production'
		Rails.logger.info 'seeds.db operating on production mode...'

		# UPDATE PRODUCTION SEEDS UPON LEAVING EXPERIMENTALS
		Rails.logger.info 'UPDATE PRODUCTION SEEDS UPON LEAVING EXPERIMENTALS'

		# USER RELATED SEED
		if User.count != 0
			User.delete_all
			Rails.logger.info 'All previous users deleted....'
		end
		# User #1 - Super User:
		User.create!(full_name: 'Sample User',
					show_full_name: true,
					display_name: 'User#1',
					email: 'user@example.com',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2001', '%m/%d/%Y'),
					gender: 'male',
					is_admin: true,
					is_super_user: true,
					facebook_url: '',
					is_banned: false,
					personal_message: 'sample personal message',
					twitter_url: 'https://twitter.com/Deovandski',
					webpage_url: 'https://www.google.com',
					privacy_terms_read: true,
					legal_terms_read: true)
		# User #2 - Admin User:
		User.create!(full_name: 'User Example',
					show_full_name: true,
					email: 'user@sample.com',
					display_name: 'User#2',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2002', '%m/%d/%Y'),
					gender: 'female',
					is_admin: true,
					is_super_user: false,
					is_banned: false,
					facebook_url: '',
					personal_message: 'Vocaloid Rules!',
					twitter_url: 'https://twitter.com/Deo',
					webpage_url: 'https://www.deovandski.blogspot.com',
					privacy_terms_read: true,
					legal_terms_read: true)
		# User #3 - Normal User:
		User.create!(full_name: 'User',
					show_full_name: true,
					email: 'test@test.com',
					display_name: 'User#3',
					password: '12345678',
					password_confirmation:'12345678',
					date_of_birth: DateTime.strptime('09/14/2003', '%m/%d/%Y'),
					gender: 'male',
					is_admin: false,
					is_super_user: false,
					is_banned: false,
					facebook_url: '',
					personal_message: 'Vocaloid Rules!',
					twitter_url: 'https://twitter.com/Deo',
					webpage_url: 'http://deovandski.heroku.com/',
					privacy_terms_read: true,
					legal_terms_read: true)
		Rails.logger.info 'Default users created!'

		# CATEGORIES RELATED SEED
		if Category.count != 0
			Category.delete_all
			Rails.logger.info 'All previous categories deleted...'
		end
		Category.create!(name: 'A-B-C') # ID 1
		Category.create!(name: 'D-E-F') # ID 2
		Category.create!(name: 'G-H-I') # ID 3
		Category.create!(name: 'J-K-L') # ID 4
		Category.create!(name: 'M-N-O') # ID 5
		Category.create!(name: 'P-Q-R') # ID 6
		Category.create!(name: 'S-T-U') # ID 7
		Category.create!(name: 'V-W-X') # ID 8
		Category.create!(name: 'Y-Z-?') # ID 9
		Rails.logger.info 'Default categories created!'

		# FACT TYPE RELATED SEED
		if FactType.count != 0
			FactType.delete_all
			Rails.logger.info 'All previous fact types deleted...'
		end
		FactType.create!(name: 'Business') # ID 1
		FactType.create!(name: 'Technology') # ID 2
		FactType.create!(name: 'International') # ID 3
		Rails.logger.info 'Default fact types created!'

		# GENRE RELATED SEED
		if Genre.count != 0
			Genre.delete_all
			Rails.logger.info 'All previous genres deleted...'
		end
		Genre.create!(name: 'Song') # ID 1
		Genre.create!(name: 'Novel') # ID 2
		Genre.create!(name: 'Movie') # ID 3
		Rails.logger.info 'Default genres created!'

		# TOPIC RELATED SEED
		if Topic.count != 0
			Topic.delete_all
			Rails.logger.info 'All previous topics deleted...'
		end
		Topic.create!(name: 'hatsune miku') # ID 1
		Topic.create!(name: 'megurine luka') # ID 2
		Rails.logger.info 'Default topics created!'

		# POST RELATED SEED
		if Post.count != 0
			Post.delete_all
			Rails.logger.info 'All previous posts deleted...'
		end
		Post.create!(fact_link: 'https://en.wikipedia.org/wiki/Hatsune_Miku',
					fiction_link: 'http://www.cbsnews.com/news/hatsune-miku-the-worlds-fakest-pop-star/',
					text: 'Miku is love! Miku is Life! No seriously, Miku is the result of how community driven creativity can bring a virtual being into real life. The Fiction article talks about Miku being a fake persona or a simple program, but if you ask the Vocaloid community, you will hear quite the different tale. Miku is not the only Vocaloid, but she is the logo of how community driven content management can not only bring people closer, but also breath life into a character that represents most of the Vocaloid community (as in all the people who have respect for her in an I-thou interpersonal relation.)',
					importance: 10,
					title: 'The concept of reality behind Hatsune Miku',
					hidden: false,
					genre_id: 1,
					fact_type_id: 2,
					topic_id: 1,
					user_id: 1,
					category_id: 3)
		Post.create!(fact_link: 'https://www.google.com',
					fact_type_id: 3,
					fiction_link: 'https://www.google.com',
					text: 'test Text',
					genre_id: 2,
					hidden: false, 
					importance: 0,
					title: 'International Novel Post with category D-E-F and topic Megurine Luka', 
					topic_id: 2,
					user_id: 1,
					category_id: 2)
		Post.create!(fact_link: 'https://www.google.com',
					fact_type_id: 1,
					fiction_link: 'https://www.google.com',
					text: 'test Text #2',
					genre_id: 3,
					hidden: false,
					importance: 0,
					title: 'Business Movie Post with category G-H-I and Megurine Luka topic',
					topic_id: 2,
					user_id: 2,
					category_id: 3)
		Rails.logger.info 'Default posts created!'

		# COMMENTS RELATED SEED

		if Comment.count == 0
			Comment.delete_all
			Rails.logger.info 'All previous comments deleted...'
		end
		Comment.create!(hidden: false,
						post_id: 1,
						text: 'Sample Text',
						user_id: 1,
						empathy_level: 0)
		Comment.create!(hidden: false,
						post_id: 2,
						text: 'Sample Text #1',
						user_id: 2,
						empathy_level: 0)
		Comment.create!(hidden: false,
						post_id: 1,
						text: 'Sample Text #1',
						user_id: 2,
						empathy_level: 0)
		Rails.logger.info 'Default comments created!'

		# ADMIN MESSAGES RELATED SEED

		if AdminMessage.count != 0
			AdminMessage.delete_all
			Rails.logger.info 'All previous admin messages deleted.'
		end
		AdminMessage.create!(title: 'Welcome to Fakktion Experimental!',
							message: 'Check Github for progress and Active Model Serializers #1238 for Deserialization. 
							Please use a unique password and if possible dummy data like random birthdates, display names and full name.
							Recommendations or if you just want to stop by to say hi, please contact me on Twitter or Github.',
							user_id: 1)
		Rails.logger.info 'Default admin messages created'

		Rails.logger.info 'seeding on production ENV ended...'
end
