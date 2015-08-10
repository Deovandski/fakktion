case Rails.env
######## Development ENV SEED
when "development"
puts "seeds.db operating on development mode..."
# USER RELATED SEED

puts "Creating Users"
if User.count == 0
# User #1 - Super User:
User.create!(full_name: "Sample User", show_full_name: true, display_name: "User#1", email: "user@example.com", password: "12345678",password_confirmation:"12345678", date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'), gender: "male", is_admin: true, is_super_user: true, facebook_url: "", personal_message: "sample personal message", twitter_url: "https://twitter.com/Deovandski", webpage_url: "www.google.com", privacy_terms_read: true, legal_terms_read: true)
# User #2 - Admin User:
User.create!(full_name: "User Example", show_full_name: true, email: "user@sample.com", display_name: "User#2", password: "12345678",password_confirmation:"12345678",date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'), gender: "female",  is_admin: true, is_super_user: false,facebook_url: "", personal_message: "Vocaloid Rules!", twitter_url: "", webpage_url: "www.deovandski.blogspot.com", privacy_terms_read: true, legal_terms_read: true)
# User #3 - Normal User:
User.create!(full_name: "User", show_full_name: true, email: "test@test.com", display_name: "User#3", password: "12345678", password_confirmation:"12345678", date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'), gender: "male",  is_admin: false, is_super_user: false,facebook_url: "https://www.facebook.com/deovandski", personal_message: "Vocaloid Rules!", twitter_url: "https://twitter.com/Deo", webpage_url: "www.deovandski.blogspot.com", privacy_terms_read: true, legal_terms_read: true)
puts "Users created"
else
User.delete_all
# User #1 - Super User:
User.create!(full_name: "Sample User", show_full_name: true, display_name: "User#1", email: "user@example.com", password: "12345678",password_confirmation:"12345678", date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'), gender: "male", is_admin: true, is_super_user: true, facebook_url: "", personal_message: "sample personal message", twitter_url: "https://twitter.com/Deovandski", webpage_url: "www.google.com", privacy_terms_read: true, legal_terms_read: true)
# User #2 - Admin User:
User.create!(full_name: "User Example", show_full_name: true, email: "user@sample.com", display_name: "User#2", password: "12345678",password_confirmation:"12345678",date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'), gender: "female",  is_admin: true, is_super_user: false,facebook_url: "", personal_message: "Vocaloid Rules!", twitter_url: "https://twitter.com/Deo", webpage_url: "www.deovandski.blogspot.com", privacy_terms_read: true, legal_terms_read: true)
# User #3 - Normal User:
User.create!(full_name: "User", show_full_name: true, email: "test@test.com", display_name: "User#3", password: "12345678", password_confirmation:"12345678", date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'), gender: "male",  is_admin: false, is_super_user: false,facebook_url: "", personal_message: "Vocaloid Rules!", twitter_url: "https://twitter.com/Deo", webpage_url: "www.deovandski.blogspot.com", privacy_terms_read: true, legal_terms_read: true)
puts "All current users deleted and created again from seed file."
end

# CATEGORIES RELATED SEED
puts "Creating Categories"
if Categorie.count == 0
Categorie.create!(name: "A-B-C")
Categorie.create!(name: "D-E-F")
Categorie.create!(name: "G-H-I")
Categorie.create!(name: "J-K-L")
Categorie.create!(name: "M-N-O")
Categorie.create!(name: "P-Q-R")
Categorie.create!(name: "S-T-U")
Categorie.create!(name: "V-W-X")
Categorie.create!(name: "Y-Z-?")
puts "Categories created"
else
Categorie.create!(name: "A-B-C")
Categorie.create!(name: "D-E-F")
Categorie.create!(name: "G-H-I")
Categorie.create!(name: "J-K-L")
Categorie.create!(name: "M-N-O")
Categorie.create!(name: "P-Q-R")
Categorie.create!(name: "S-T-U")
Categorie.create!(name: "V-W-X")
Categorie.create!(name: "Y-Z-?")
puts "All current categories deleted and created again from seed file."
end

# FACT TYPE RELATED SEED
puts "Creating fact types"
if FactType.count == 0
FactType.create!(name: "Business")
FactType.create!(name: "Technology")
FactType.create!(name: "International")
puts "Fact types created"
else
FactType.create!(name: "Business")
FactType.create!(name: "Technology")
FactType.create!(name: "International")
puts "All current fact types deleted and created again from seed file."
end

# GENRE RELATED SEED
puts "Creating Genres"
if Genre.count == 0
Genre.create!(name: "Song")
Genre.create!(name: "Novel")
Genre.create!(name: "Movie")
puts "Genres created"
else
Genre.create!(name: "Song")
Genre.create!(name: "Novel")
Genre.create!(name: "Movie")
puts "All current genres deleted and created again from seed file."
end

# TOPIC RELATED SEED
puts "Creating topics"
if Topic.count == 0
Topic.create!(name: "Hatsune Miku")
puts "Topics created"
else
Topic.create!(name: "Hatsune Miku")
puts "All current topics deleted and created again from seed file."
end

# POST RELATED SEED
puts "Creating posts"
if Post.count == 0
Post.create!(fact_link: "test fact link", fact_type_id: 1, fiction_link: "test fiction link", text: "Miku is love! Miku is Life! No seriously, Miku is the result of how community driven creativity can bring a virtual being into life.", genre_id: 1, hidden: false, importance: 0, title: "The concept of reality behind Hatsune Miku", soft_delete: false, soft_delete_date: nil, topic_id: 0, user_id: 0,categorie_id: 2)
Post.create!(fact_link: "test fact link", fact_type_id: 2, fiction_link: "test fiction link", text: "test Text", genre_id: 2, hidden: false, importance: 0, title: "test Novel Post with category D-E-F", soft_delete: false, soft_delete_date: nil, topic_id: 0, user_id: 0,categorie_id: 1)
Post.create!(fact_link: "test fact link #2", fact_type_id: 1, fiction_link: "test fiction link #2", text: "test Text #2", genre_id: 3, hidden: false, importance: 0, title: "test Novel Post with category G-H-I", soft_delete: false, soft_delete_date: nil, topic_id: 0, user_id: 0,categorie_id: 3)
puts "Posts created"
else
Post.create!(fact_link: "test fact link", fact_type_id: 1, fiction_link: "test fiction link", text: "Miku is love! Miku is Life! No seriously, Miku is the result of how community driven creativity can bring a virtual being into life.", genre_id: 1, hidden: false, importance: 0, title: "The concept of reality behind Hatsune Miku", soft_delete: false, soft_delete_date: nil, topic_id: 0, user_id: 0,categorie_id: 2)
Post.create!(fact_link: "test fact link", fact_type_id: 2, fiction_link: "test fiction link", text: "test Text", genre_id: 2, hidden: false, importance: 0, title: "test Novel Post with category D-E-F", soft_delete: false, soft_delete_date: nil, topic_id: 0, user_id: 0,categorie_id: 1)
Post.create!(fact_link: "test fact link #2", fact_type_id: 1, fiction_link: "test fiction link #2", text: "test Text #2", genre_id: 3, hidden: false, importance: 0, title: "test Novel Post with category G-H-I", soft_delete: false, soft_delete_date: nil, topic_id: 0, user_id: 0,categorie_id: 3)
puts "Posts created"
puts "All current posts deleted and created again from seed file."
end

# COMMENTS RELATED SEED
puts "Creating Comments"
if Comment.count == 0
Comment.create!(hidden: false, post_id: 0, soft_delete: false, soft_delete_date: nil, text: "Sample Text #1", user_id: 1, empathy_level: 0)
Comment.create!(hidden: false, post_id: 0, soft_delete: false, soft_delete_date: nil, text: "Sample Text #2 by Admin", user_id: 0, empathy_level: 0)
puts "Comments created"
else
Comment.create!(hidden: false, post_id: 0, soft_delete: false, soft_delete_date: nil, text: "Sample Text #1", user_id: 1, empathy_level: 0)
Comment.create!(hidden: false, post_id: 0, soft_delete: false, soft_delete_date: nil, text: "Sample Text #2 by Admin", user_id: 0, empathy_level: 0)
puts "All current comments deleted and created again from seed file."
end

# ADMIN MESSAGES RELATED SEED
puts "Creating admin messages"
if AdminMessage.count == 0
AdminMessage.create!(title: "Welcome Message", message: "Welcome to Fakktion! This is the first Admin Message", user_id: 0)
puts "Admin messages created"
else
AdminMessage.create!(title: "Welcome Message", message: "Welcome to Fakktion! This is the first Admin Message", user_id: 0)
puts "All current admin messages deleted and created again from seed file."
end

puts "seeding on development ENV ended..."
######## Test ENV SEED
when "test"
puts "seeds.db operating on test mode..."
# TODO
puts "seeding on test ENV ended..."
######## Production ENV SEED
when "production"
puts "seeds.db operating on production mode..."
# TODO
puts "seeding on production ENV ended..."
end
