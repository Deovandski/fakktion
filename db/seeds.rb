# Seeds
case Rails.env

################ Development ENV SEED ################

	when 'development'
		Rails.logger.info 'seeds.db operating on development mode...'

		# USER RELATED SEED

		if User.count == 0
			Rails.logger.info 'Creating Users...'
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
						date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'),
						gender: 'female',
						is_admin: true,
						is_super_user: false,
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
			Rails.logger.info 'Users created!'
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
						webpage_url: 'https://www.deovandski.blogspot.com',
						privacy_terms_read: true,
						legal_terms_read: true)
			Rails.logger.info 'All current users deleted and created again from seed file...'
		end

		# CATEGORIES RELATED SEED

		if Category.count == 0
			Rails.logger.info 'Creating Categories...'
			Category.create!(name: 'A-B-C') # ID 1
			Category.create!(name: 'D-E-F') # ID 2
			Category.create!(name: 'G-H-I') # ID 3
			Category.create!(name: 'J-K-L') # ID 4
			Category.create!(name: 'M-N-O') # ID 5
			Category.create!(name: 'P-Q-R') # ID 6
			Category.create!(name: 'S-T-U') # ID 7
			Category.create!(name: 'V-W-X') # ID 8
			Category.create!(name: 'Y-Z-?') # ID 9
			Rails.logger.info 'Categories created!'
		else
			Category.delete_all
			Category.create!(name: 'A-B-C') # ID 1
			Category.create!(name: 'D-E-F') # ID 2
			Category.create!(name: 'G-H-I') # ID 3
			Category.create!(name: 'J-K-L') # ID 4
			Category.create!(name: 'M-N-O') # ID 5
			Category.create!(name: 'P-Q-R') # ID 6
			Category.create!(name: 'S-T-U') # ID 7
			Category.create!(name: 'V-W-X') # ID 8
			Category.create!(name: 'Y-Z-?') # ID 9
			Rails.logger.info 'All current Categories deleted and created again from seed file...'
		end

		# FACT TYPE RELATED SEED
		if FactType.count == 0
			Rails.logger.info 'Creating Fact Types...'
			FactType.create!(name: 'Business') # ID 1
			FactType.create!(name: 'Technology') # ID 2
			FactType.create!(name: 'International') # ID 3
			Rails.logger.info 'Fact types created!'
		else
			FactType.delete_all
			FactType.create!(name: 'Business') # ID 1
			FactType.create!(name: 'Technology') # ID 2
			FactType.create!(name: 'International') # ID 3
			Rails.logger.info 'All current Fact Types deleted and created again from seed file...'
		end

		# GENRE RELATED SEED
		if Genre.count == 0
			Rails.logger.info 'Creating Genres...'
			Genre.create!(name: 'Song') # ID 1
			Genre.create!(name: 'Novel') # ID 2
			Genre.create!(name: 'Movie') # ID 3
			Rails.logger.info 'Genres created!'
		else
			Genre.delete_all
			Genre.create!(name: 'Song') # ID 1
			Genre.create!(name: 'Novel') # ID 2
			Genre.create!(name: 'Movie') # ID 3
			Rails.logger.info 'All current genres deleted and created again from seed file...'
		end

		# TOPIC RELATED SEED
		if Topic.count == 0
			Rails.logger.info 'Creating Topics...'
			Topic.create!(name: 'hatsune miku') # ID 1
			Topic.create!(name: 'megurine luka') # ID 2
			Rails.logger.info 'Topics created!'
		else
			Topic.delete_all
			Topic.create!(name: 'hatsune miku') # ID 1
			Topic.create!(name: 'megurine luka') # ID 2
			Rails.logger.info 'All current topics deleted and created again from seed file.'
		end

		# POST RELATED SEED
		if Post.count == 0
			Rails.logger.info 'Creating Posts...'
			Post.create!(fact_link: 'https://en.wikipedia.org/wiki/Hatsune_Miku',
						fiction_link: 'http://www.cbsnews.com/news/hatsune-miku-the-worlds-fakest-pop-star/',
						text: 'Miku is love! Miku is Life! No seriously, Miku is the result of how community driven creativity can bring a virtual being into real life. The Fiction article talks about Miku being a fake persona or a simple program, but if you ask the Vocaloid community, you will hear quite the different tale. Miku is not the only Vocaloid, but she is the logo of how community driven content management can not only bring people closer, but also breath life into a character that represents most of the Vocaloid community (as in all the people who have respect for her in an I-thou interpersonal relation.)',
						importance: 10,
						title: 'The concept of reality behind Hatsune Miku',
						soft_delete: false,
						soft_delete_date: nil,
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
						soft_delete: false,
						soft_delete_date: nil,
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
						soft_delete: false,
						soft_delete_date: nil,
						topic_id: 2,
						user_id: 2,
						category_id: 3)
			Rails.logger.info 'Posts created'
		else
			Post.delete_all
			Post.create!(fact_link: 'https://en.wikipedia.org/wiki/Hatsune_Miku',
						fiction_link: 'http://www.cbsnews.com/news/hatsune-miku-the-worlds-fakest-pop-star/',
						text: 'Miku is love! Miku is Life! No seriously, Miku is the result of how community driven creativity can bring a virtual being into real life. The Fiction article talks about Miku being a fake persona or a simple program, but if you ask the Vocaloid community, you will hear quite the different tale. Miku is not the only Vocaloid, but she is the logo of how community driven content management can not only bring people closer, but also breath life into a character that represents most of the Vocaloid community (as in all the people who have respect for her in an I-thou interpersonal relation.)',
						importance: 10,
						title: 'The concept of reality behind Hatsune Miku',
						soft_delete: false,
						soft_delete_date: nil,
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
						soft_delete: false,
						soft_delete_date: nil,
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
						soft_delete: false,
						soft_delete_date: nil,
						topic_id: 2,
						user_id: 2,
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
							post_id: 2,
							soft_delete: false,
							soft_delete_date: nil,
							text: 'Sample Text',
							user_id: 2,
							empathy_level: 0)
			Rails.logger.info 'Comments created'
		else
			Comment.delete_all
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
							user_id: 2,
							empathy_level: 0)
			Rails.logger.info 'All current comments deleted and created again from seed file.'
		end

		# ADMIN MESSAGES RELATED SEED

		Rails.logger.info 'Creating admin messages'
		if AdminMessage.count == 0
			AdminMessage.create!(title: 'Welcome to Fakktion Experimental!',
								message: 'Check Github for progress and Active Model Serializers #1238 for Deserialization. 
								Please use a unique password and if possible dummy data like random birthdates, display names and full name.
								Recommendations or if you just want to stop by to say hi, please contact me on Twitter or Github.',
								user_id: 1)
			Rails.logger.info 'Admin messages created'
		else
			AdminMessage.delete_all
			AdminMessage.create!(title: 'Welcome to Fakktion Experimental!',
								message: 'Check Github for progress and Active Model Serializers #1238 for Deserialization. 
								Please use a unique password and if possible dummy data like random birthdates, display names and full name.
								Recommendations or if you just want to stop by to say hi, please contact me on Twitter or Github.',
								user_id: 1)
			Rails.logger.info 'All current admin messages deleted and created again from seed file.'
		end

		Rails.logger.info 'seeding on development ENV ended...'

################ Test ENV SEED ################

	when 'test'
		Rails.logger.info 'seeds.db operating on test mode...'

		# USERS SEED

		if User.count == 0
			Rails.logger.info 'Creating Users...'
			# User #1 - Super User:
			User.create!(full_name: 'Sample User',
						show_full_name: true,
						display_name: 'User#1',
						email: 'user@example.com',
						password: '12345678',
						password_confirmation:'12345678',
						date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'),
						gender: 'male',
						is_admin: true,
						is_super_user: true,
						facebook_url: '',
						personal_message: 'sample personal message',
						twitter_url: 'https://twitter.com/Deovandski',
						webpage_url: 'https://www.google.com',
						privacy_terms_read: true,
						legal_terms_read: true)
			Rails.logger.info 'Users created...'
		else
			Rails.logger.info 'no Users created...'
		end

		# CATEGORIES SEED

		if Category.count == 0
			Rails.logger.info 'Creating Categories...'
			Category.create!(name: 'A-B-C') # ID 1
			Category.create!(name: 'D-E-F') # ID 2
			Category.create!(name: 'G-H-I') # ID 3
			Category.create!(name: 'J-K-L') # ID 4
			Category.create!(name: 'M-N-O') # ID 5
			Category.create!(name: 'P-Q-R') # ID 6
			Category.create!(name: 'S-T-U') # ID 7
			Category.create!(name: 'V-W-X') # ID 8
			Category.create!(name: 'Y-Z-?') # ID 9
			Rails.logger.info 'Categories created'
		else
			Rails.logger.info 'no Categories created...'
		end

		# FACT TYPE RELATED SEED

		if FactType.count == 0
			Rails.logger.info 'Creating Fact Types...'
			FactType.create!(name: 'Business') # ID 1
			FactType.create!(name: 'Technology') # ID 2
			FactType.create!(name: 'International') # ID 3
			Rails.logger.info 'Fact Types created!'
		else
			Rails.logger.info 'no Fact Types created...'
		end

		# GENRE RELATED SEED

		if Genre.count == 0
			Rails.logger.info 'Creating Genres...'
			Genre.create!(name: 'Song') # ID 1
			Genre.create!(name: 'Novel') # ID 2
			Genre.create!(name: 'Movie') # ID 3
			Rails.logger.info 'Genres created!'
		else
			Rails.logger.info 'no Genres created...'
		end

		# TOPIC RELATED SEED

		if Topic.count == 0
			Rails.logger.info 'Creating Topics...'
			Topic.create!(name: 'hatsune miku') # ID 1
			Topic.create!(name: 'megurine luka') # ID 2
			Rails.logger.info 'Topics created!'
		else
			Rails.logger.info 'no Topics created...'
		end

		# POST RELATED SEED

		if Post.count == 0
			Rails.logger.info 'Creating Posts...'
			Post.create!(fact_link: 'https://en.wikipedia.org/wiki/Hatsune_Miku',
						fiction_link: 'http://www.cbsnews.com/news/hatsune-miku-the-worlds-fakest-pop-star/',
						text: 'Miku is love! Miku is Life! No seriously, Miku is the result of how community driven creativity can bring a virtual being into real life. The Fiction article talks about Miku being a fake persona or a simple program, but if you ask the Vocaloid community, you will hear quite the different tale. Miku is not the only Vocaloid, but she is the logo of how community driven content management can not only bring people closer, but also breath life into a character that represents most of the Vocaloid community (as in all the people who have respect for her in an I-thou interpersonal relation.)',
						importance: 10,
						title: 'The concept of reality behind Hatsune Miku',
						soft_delete: false,
						soft_delete_date: nil,
						hidden: false,
						genre_id: 1,
						fact_type_id: 2,
						topic_id: 1,
						user_id: 1,
						category_id: 3)
			Rails.logger.info 'Posts created!'
		else
			Rails.logger.info 'no new Posts created...'
		end

		# ADMIN MESSAGES RELATED SEED

		if AdminMessage.count == 0
			Rails.logger.info 'Creating admin messages...'
			AdminMessage.create!(title: 'Welcome to Fakktion Experimental!',
								message: 'Check Github for progress and Active Model Serializers #1238 for Deserialization. 
								Please use a unique password and if possible dummy data like random birthdates, display names and full name.
								Recommendations or if you just want to stop by to say hi, please contact me on Twitter or Github.',
								user_id: 1)
			Rails.logger.info 'Admin messages created!'
		else
			Rails.logger.info 'no Admin Messages created...'
		end
		Rails.logger.info 'seeding on test ENV ended...'

################ Production ENV SEED ################

	when 'production'
		Rails.logger.info 'seeds.db operating on production mode...'

		# USERS SEED

		if User.count == 0
			Rails.logger.info 'Creating Users...'
			# User #1 - Super User:
			User.create!(full_name: 'Sample User',
						show_full_name: true,
						display_name: 'User#1',
						email: 'user@example.com',
						password: '12345678',
						password_confirmation:'12345678',
						date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'),
						gender: 'male',
						is_admin: true,
						is_super_user: true,
						facebook_url: '',
						personal_message: 'sample personal message',
						twitter_url: 'https://twitter.com/Deovandski',
						webpage_url: 'https://www.google.com',
						privacy_terms_read: true,
						legal_terms_read: true)
			Rails.logger.info 'Users created...'
		else
			Rails.logger.info 'no Users Categories...'
		end

		# CATEGORIES SEED

		if Category.count == 0
			Rails.logger.info 'Creating Categories...'
			Category.create!(name: 'A-B-C') # ID 1
			Category.create!(name: 'D-E-F') # ID 2
			Category.create!(name: 'G-H-I') # ID 3
			Category.create!(name: 'J-K-L') # ID 4
			Category.create!(name: 'M-N-O') # ID 5
			Category.create!(name: 'P-Q-R') # ID 6
			Category.create!(name: 'S-T-U') # ID 7
			Category.create!(name: 'V-W-X') # ID 8
			Category.create!(name: 'Y-Z-?') # ID 9
			Rails.logger.info 'Categories created'
		else
			Rails.logger.info 'no Categories created...'
		end

		# FACT TYPE RELATED SEED

		if FactType.count == 0
			Rails.logger.info 'Creating Fact Types...'
			FactType.create!(name: 'Business') # ID 1
			FactType.create!(name: 'Technology') # ID 2
			FactType.create!(name: 'International') # ID 3
			Rails.logger.info 'Fact Types created!'
		else
			Rails.logger.info 'no Fact Types created...'
		end

		# GENRE RELATED SEED

		if Genre.count == 0
			Rails.logger.info 'Creating Genres...'
			Genre.create!(name: 'Song') # ID 1
			Genre.create!(name: 'Novel') # ID 2
			Genre.create!(name: 'Movie') # ID 3
			Rails.logger.info 'Genres created!'
		else
			Rails.logger.info 'no Genres created...'
		end

		# TOPIC RELATED SEED

		if Topic.count == 0
			Rails.logger.info 'Creating Topics...'
			Topic.create!(name: 'hatsune miku') # ID 1
			Topic.create!(name: 'megurine luka') # ID 2
			Rails.logger.info 'Topics created!'
		else
			Rails.logger.info 'no Topics created...'
		end

		# POST RELATED SEED

		if Post.count == 0
			Rails.logger.info 'Creating Posts...'
			Post.create!(fact_link: 'https://en.wikipedia.org/wiki/Hatsune_Miku',
						fiction_link: 'http://www.cbsnews.com/news/hatsune-miku-the-worlds-fakest-pop-star/',
						text: 'Miku is love! Miku is Life! No seriously, Miku is the result of how community driven creativity can bring a virtual being into real life. The Fiction article talks about Miku being a fake persona or a simple program, but if you ask the Vocaloid community, you will hear quite the different tale. Miku is not the only Vocaloid, but she is the logo of how community driven content management can not only bring people closer, but also breath life into a character that represents most of the Vocaloid community (as in all the people who have respect for her in an I-thou interpersonal relation.)',
						importance: 10,
						title: 'The concept of reality behind Hatsune Miku',
						soft_delete: false,
						soft_delete_date: nil,
						hidden: false,
						genre_id: 1,
						fact_type_id: 2,
						topic_id: 1,
						user_id: 1,
						category_id: 3)
			Rails.logger.info 'Posts created!'
		else
			Rails.logger.info 'no new Posts created...'
		end

		# ADMIN MESSAGES RELATED SEED

		if AdminMessage.count == 0
			Rails.logger.info 'Creating admin messages...'
			AdminMessage.create!(title: 'Welcome to Fakktion Experimental!',
								message: 'Check Github for progress and Active Model Serializers #1238 for Deserialization. 
								Please use a unique password and if possible dummy data like random birthdates, display names and full name.
								Recommendations or if you just want to stop by to say hi, please contact me on Twitter or Github.',
								user_id: 1)
			Rails.logger.info 'Admin messages created!'
		else
			Rails.logger.info 'no Admin Messages created...'
		end

		Rails.logger.info 'seeding on production ENV ended...'
end
