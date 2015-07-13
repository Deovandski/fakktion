# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# USER RELATED SEED
if User.count == 0
puts "Creating Users"

# User #1 - Super User:
User.create!(full_name: "Sample User", display_name: "User#1", email: "user@example.com", password: "12345678",password_confirmation:"12345678", date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'), gender: "male", is_admin: true, is_super_user: true, facebook_id: 3, personal_message: "sample personal message", twitter_url: "https://twitter.com/Deovandski", webpage_url: "www.google.com", privacy_terms_read: true, legal_terms_read: true)

# User #2 - Admin User:
User.create!(full_name: "User Example", email: "user@sample.com", display_name: "User#2", password: "12345678",password_confirmation:"12345678",date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'), gender: "female",  is_admin: true, is_super_user: false,facebook_id: 1, personal_message: "Vocaloid Rules!", twitter_url: "https://twitter.com/Deo", webpage_url: "www.deovandski.blogspot.com", privacy_terms_read: true, legal_terms_read: true)

# User #3 - Normal User:
User.create!(full_name: "User", email: "test@test.com", display_name: "User#3", password: "12345678", password_confirmation:"12345678", date_of_birth: DateTime.strptime('09/14/2009', '%m/%d/%Y'), gender: "male",  is_admin: false, is_super_user: false,facebook_id: 1, personal_message: "Vocaloid Rules!", twitter_url: "https://twitter.com/Deo", webpage_url: "www.deovandski.blogspot.com", privacy_terms_read: true, legal_terms_read: true)

puts "Users created"
else
puts "No new users created as there is already at least one 1 user in the database"
end

# CATEGORIES RELATED SEED
puts "Creating Categories"
if Categorie.count == 0
Categorie.create!(category_name: "A-B-C")
Categorie.create!(category_name: "D-E-F")
Categorie.create!(category_name: "G-H-I")
Categorie.create!(category_name: "J-K-L")
Categorie.create!(category_name: "M-N-O")
Categorie.create!(category_name: "P-Q-R")
Categorie.create!(category_name: "S-T-U")
Categorie.create!(category_name: "V-W-X")
Categorie.create!(category_name: "Y-Z-?")
puts "Categories created"
else
puts "No new categories created as there is already at least one 1 category in the database"
end

# FACT TYPE RELATED SEED
puts "Creating fact types"
if FactType.count == 0
FactType.create!(fact_name: "Business")
FactType.create!(fact_name: "Technology")
FactType.create!(fact_name: "International")
puts "Fact types created"
else
puts "No new fact types created as there is already at least one 1 fact type in the database"
end

# GENRE RELATED SEED
puts "Creating Genres"
if Genre.count == 0
Genre.create!(genre_name: "Song")
Genre.create!(genre_name: "Novel")
Genre.create!(genre_name: "Movie")
puts "Genres created"
else
puts "No new Genres created as there is already at least one 1 fact type in the database"
end

# TOPIC RELATED SEED
puts "Creating topics"
if Topic.count == 0
Topic.create!(topic_name: "Hatsune Miku")
puts "Topics created"
else
puts "No new Topics created as there is already at least one topic in the database"
end

# POST RELATED SEED
puts "Creating posts"
if Post.count == 0
Post.create!(fact_link: "test fact link", fact_type_id: 1, fiction_link: "test fiction link", text: "Miku is love! Miku is Life! No seriously, Miku is the result of how community driven creativity can bring a virtual being into life.", genre_id: 1, hidden: false, importance: 0, title: "The concept of reality behind Hatsune Miku", soft_delete: false, soft_delete_date: nil, topic_id: 0, user_id: 0,categorie_id: 2)

Post.create!(fact_link: "test fact link", fact_type_id: 2, fiction_link: "test fiction link", text: "test Text", genre_id: 2, hidden: false, importance: 0, title: "test Novel Post with category D-E-F", soft_delete: false, soft_delete_date: nil, topic_id: 0, user_id: 0,categorie_id: 1)

Post.create!(fact_link: "test fact link #2", fact_type_id: 1, fiction_link: "test fiction link #2", text: "test Text #2", genre_id: 3, hidden: false, importance: 0, title: "test Novel Post with category G-H-I", soft_delete: false, soft_delete_date: nil, topic_id: 0, user_id: 0,categorie_id: 3)
puts "Posts created"
else
puts "No new posts created as there is already at least one 1 post in the database"
end

# COMMENTS RELATED SEED
puts "Creating Comments"
if Comment.count == 0
Comment.create!(hidden: false, post_id: 0, soft_delete: false, soft_delete_date: nil, text: "Sample Text #1", user_id: 1, empathy_level: 0)
Comment.create!(hidden: false, post_id: 0, soft_delete: false, soft_delete_date: nil, text: "Sample Text #2 by Admin", user_id: 0, empathy_level: 0)
puts "Comments created"
else
puts "No new comments created as there is already at least one 1 comment in the database"
end


# ADMIN MESSSAGES RELATED SEED
puts "Creating admin messages"
if AdminMessage.count == 0
AdminMessage.create!(title: "Welcome Message", message: "Welcome to Fakktion! This is the first Admin Message", user_id: 0)
puts "Admin messages created"
else
puts "No new admin messages created as there is already at least one 1 admin message in the database"
end

