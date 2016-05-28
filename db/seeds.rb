# Seeds.rb is now one for all.
# USER RELATED SEED
if User.count != 0
  User.delete_all
  Rails.logger.info 'All previous users deleted....'
end

# User #1 - Admin User:
User.create!(full_name: 'Sample User',
  show_full_name: true,
  display_name: 'User#1',
  email: 'user@example.com',
  password: '12345678',
  password_confirmation:'12345678',
  date_of_birth: DateTime.strptime('09/14/2001', '%m/%d/%Y'),
  is_admin: true,
  is_banned: false,
  facebook_url: '',
  times_banned: 0,
  personal_message: 'sample personal message',
  twitter_url: 'https://twitter.com/Deovandski',
  webpage_url: 'https://www.google.com',
  privacy_terms_read: true,
  legal_terms_read: true)
# User #2 - Normal User:
User.create!(full_name: 'User Example',
  show_full_name: true,
  email: 'user@sample.com',
  display_name: 'User#2',
  password: '12345678',
  times_banned: 0,
  password_confirmation:'12345678',
  date_of_birth: DateTime.strptime('09/14/2002', '%m/%d/%Y'),
  is_admin: false,
  is_banned: false,
  facebook_url: '',
  personal_message: 'Vocaloid Rules!',
  twitter_url: 'https://twitter.com/Deo',
  webpage_url: 'https://www.deovandski.blogspot.com',
  privacy_terms_read: true,
  legal_terms_read: true)
# User #3 - Banned User:
User.create!(full_name: 'Banned User Example',
  show_full_name: true,
  email: 'user@user.com',
  display_name: 'User#3',
  password: '12345678',
  times_banned: 3,
  password_confirmation:'12345678',
  date_of_birth: DateTime.strptime('09/14/2002', '%m/%d/%Y'),
  is_admin: false,
  is_banned: false,
  facebook_url: '',
  personal_message: 'Vocaloid Rules!',
  twitter_url: 'https://twitter.com/Deo',
  webpage_url: 'https://www.deovandski.blogspot.com',
  privacy_terms_read: true,
  legal_terms_read: true)
Rails.logger.info 'Default users created!'

# CATEGORIES RELATED SEED
if Category.count != 0
  Category.delete_all
  Rails.logger.info 'All previous categories deleted...'
end
Category.create!(name: 'Gaming')
Category.create!(name: 'Song')
Category.create!(name: 'Movie')
Category.create!(name: 'Television')
Category.create!(name: 'Musical')
Category.create!(name: 'Book')
Category.create!(name: 'Radio')
Category.create!(name: 'Newspaper')
Category.create!(name: 'Vocaloid')
Rails.logger.info 'Default categories created!'

# FACT TYPE RELATED SEED
if FactType.count != 0
  FactType.delete_all
  Rails.logger.info 'All previous fact types deleted...'
end
FactType.create!(name: 'Technology')
FactType.create!(name: 'Business')
FactType.create!(name: 'Immigration')
FactType.create!(name: 'Environment')
Rails.logger.info 'Default fact types created!'

# GENRE RELATED SEED
if Genre.count != 0
  Genre.delete_all
  Rails.logger.info 'All previous genres deleted...'
end
Genre.create!(name: 'surreal')
Genre.create!(name: 'Action')
Genre.create!(name: 'Adventure')
Genre.create!(name: 'Comedy')
Genre.create!(name: 'Crime')
Genre.create!(name: 'Drama')
Genre.create!(name: 'Fantasy')
Genre.create!(name: 'Historical')
Genre.create!(name: 'Horror')
Genre.create!(name: 'Mystery')
Genre.create!(name: 'Paranoid')
Genre.create!(name: 'Philosophy')
Genre.create!(name: 'Political')
Genre.create!(name: 'Romance')
Genre.create!(name: 'Saga')
Genre.create!(name: 'Satire')
Genre.create!(name: 'Science')
Genre.create!(name: 'Thriller')
Genre.create!(name: 'Urban')
Genre.create!(name: 'Western')
Rails.logger.info 'Default genres created!'

# TOPIC RELATED SEED
if Topic.count != 0
  Topic.delete_all
  Rails.logger.info 'All previous topics deleted...'
end
Topic.create!(name: 'hatsune miku')
Topic.create!(name: 'megurine luka')
Rails.logger.info 'Default topics created!'

# Post Relationships
ComedyGenre = Genre.find_by name: 'comedy'
songCategory = Category.find_by name: 'song'
mikuTopic = Topic.find_by name: 'hatsune miku'
firstUser = User.first
technologyFactType = FactType.find_by name: 'technology'

# POST RELATED SEED
if Post.count != 0
  Post.delete_all
  Rails.logger.info 'All previous posts deleted...'
end
Post.create!(fact_link: 'https://en.wikipedia.org/wiki/Hatsune_Miku',
  fiction_link: 'http://www.cbsnews.com/news/hatsune-miku-the-worlds-fakest-pop-star/',
  text: '<h3>Miku is love! Miku is Life!</h3> <p>No seriously, Miku is the result of how community driven creativity can bring a virtual being into real life. The Fiction article talks about Miku being a fake persona or a simple program, but if you ask the Vocaloid community, you will hear quite the different tale. Miku is not the only Vocaloid, but she is the logo of how community driven content management can not only bring people closer, but also breath life into a character that represents most of the Vocaloid community (as in all the people who have respect for her in an I-thou interpersonal relation.)</p>',
  title: 'The concept of reality behind Hatsune Miku',
  hidden: false,
  genre_id: ComedyGenre.id,
  fact_type_id: technologyFactType.id,
  topic_id: mikuTopic.id,
  user_id: firstUser.id,
  category_id: songCategory.id)

# COMMENTS RELATED SEED

if Comment.count != 0
  Comment.delete_all
  Rails.logger.info 'All previous comments deleted...'
end

mikuPost = Post.first
Comment.create!(hidden: false,
  post_id: mikuPost.id,
  text: 'Sample Text',
  user_id: firstUser.id,
  empathy_level: 0)
Comment.create!(hidden: false,
  post_id: mikuPost.id,
  text: 'Sample Text #1',
  user_id: firstUser.id,
  empathy_level: 0)
Rails.logger.info 'Default comments created!'

# INNER COMMENTS RELATED SEED

if InnerComment.count != 0
  InnerComment.delete_all
  Rails.logger.info 'All previous comments deleted...'
end

firstComment = Comment.first

InnerComment.create!(hidden: false,
  comment_id: firstComment.id,
 text: 'Sample Inner Text',
 user_id: firstUser.id,
  empathy_level: 0)
InnerComment.create!(hidden: false,
  comment_id: firstComment.id,
  text: 'Sample Inner Text #1',
  user_id: firstUser.id,
  empathy_level: 0)
Rails.logger.info 'Default comments created!'

# ADMIN MESSAGES RELATED SEED

if AdminMessage.count != 0
  AdminMessage.delete_all
  Rails.logger.info 'All previous admin messages deleted.'
end
AdminMessage.create!(title: 'Welcome to Fakktion Experimental!',
  message: 'Please use a unique password and if possible dummy data like random birthdates, display names and full name.
  Recommendations or if you just want to stop by to say hi, please contact me on Twitter or create an issue on Github.',
  user_id: 1)
Rails.logger.info 'Default admin messages created'
