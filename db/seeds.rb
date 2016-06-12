# Seeds.rb

# USER RELATED SEED
if User.count != 0
  Rails.logger.info 'There are users already...'
else
  # User #1 - Legend User:
  User.create!(full_name: 'Sample User',
    show_full_name: true,
    display_name: 'User#1',
    email: 'user@example.com',
    reputation: 4000,
    password: '12345678',
    password_confirmation:'12345678',
    date_of_birth: DateTime.strptime('09/14/2001', '%m/%d/%Y'),
    is_super_user: true,
    is_admin: true,
    is_legend: true,
    facebook_url: '',
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
    reputation: 0,
    password: '12345678',
    password_confirmation:'12345678',
    date_of_birth: DateTime.strptime('09/14/2002', '%m/%d/%Y'),
    is_super_user: false,
    is_admin: false,
    is_legend: false,
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
    reputation: -3600,
    password: '12345678',
    password_confirmation:'12345678',
    date_of_birth: DateTime.strptime('09/14/2002', '%m/%d/%Y'),
    is_super_user: false,
    is_admin: false,
    is_legend: false,
    facebook_url: '',
    personal_message: 'Vocaloid Rules!',
    twitter_url: 'https://twitter.com/Deo',
    webpage_url: 'https://www.deovandski.blogspot.com',
    privacy_terms_read: true,
    legal_terms_read: true)
  Rails.logger.info 'Default users created!'
end

# CATEGORIES RELATED SEED
if Category.count != 0
  Rails.logger.info 'There are categories already...'
else
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
end

# FACT TYPE RELATED SEED
if FactType.count != 0
  Rails.logger.info 'There are fact types already...'
else
  FactType.create!(name: 'Technology')
  FactType.create!(name: 'Business')
  FactType.create!(name: 'Immigration')
  FactType.create!(name: 'Environment')
  Rails.logger.info 'Default fact types created!'
end

# GENRE RELATED SEED
if Genre.count != 0
  Rails.logger.info 'There are genres already...'
else
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
end

# TOPIC RELATED SEED
if Topic.count != 0
  Rails.logger.info 'There are topics already...'
else
  Topic.create!(name: 'hatsune miku')
  Topic.create!(name: 'megurine luka')
  Topic.create!(name: 'kagamine rin')
  Topic.create!(name: 'Kagamine len')
  Rails.logger.info 'Default topics created!'
end

# POST RELATED SEED
if Post.count != 0
  Rails.logger.info 'There are posts already...'
else
  # Post Relationships
  ComedyGenre = Genre.find_by name: 'comedy'
  songCategory = Category.find_by name: 'song'
  mikuTopic = Topic.find_by name: 'hatsune miku'
  firstUser = User.first
  technologyFactType = FactType.find_by name: 'technology'
  Post.create!(fact_link: 'https://en.wikipedia.org/wiki/Hatsune_Miku',
    fiction_link: 'http://www.cbsnews.com/news/hatsune-miku-the-worlds-fakest-pop-star/',
    text: '<h5>Miku is love! Miku is Life!</h5> <p>No seriously, Miku is the result of how community driven creativity can bring a virtual being into real life.</p><p> The Fiction article talks about Miku being a fake persona or a simple program, but if you ask the Vocaloid community, you will hear quite the different tale. Miku is not the only Vocaloid, but she is the logo of how community driven content management can not only bring people closer, but also breath life into a character that represents most of the Vocaloid community (as in all the people who have respect for her in an I-thou interpersonal relation.)</p><ol><li>Do you agree that virtual being can attain the status of real due to the breath of life given by a community behind him/her?</li><li>If not, then what would be required to allow those virtual beings being cosidered real?</li></ol>',
    title: 'The concept of reality behind Hatsune Miku',
    genre_id: ComedyGenre.id,
    fact_type_id: technologyFactType.id,
    topic_id: mikuTopic.id,
    user_id: firstUser.id,
    category_id: songCategory.id)
end
