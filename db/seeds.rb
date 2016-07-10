# Seeds.rb

# ENV SPECIFIC SEEDING
def seed_users
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
end

case Rails.env
  when 'development' then seed_users
  when 'test' then seed_users
  when 'production'
    # USER RELATED SEED
    if User.count != 0
      Rails.logger.info 'There are users already...'
    else
    # User #1 - Deovandski:
    User.create!(full_name: 'Deovandski Skibinski Junior',
      show_full_name: true,
      display_name: 'Deovandski',
      email: 'deovandski@outlook.com',
      reputation: 2000,
      password: '12345678',
      password_confirmation:'12345678',
      date_of_birth: DateTime.strptime('05/15/1993', '%m/%d/%Y'),
      is_super_user: true,
      is_admin: true,
      is_legend: false,
      personal_message: 'sample personal message',
      facebook_url: 'https://www.facebook.com/deovandski',
      twitter_url: 'https://twitter.com/Deovandski',
      webpage_url: 'https://deovandski.blogspot.com/',
      privacy_terms_read: true,
      legal_terms_read: true)
    end
end


# SHARED SEEDS

# CATEGORIES RELATED SEED
if Category.count != 0
  Rails.logger.info 'There are categories already...'
else
  Category.create!(name: 'Game')
  Category.create!(name: 'Song')
  Category.create!(name: 'Movie')
  Category.create!(name: 'Musical')
  Category.create!(name: 'Book')
  Category.create!(name: 'Vocaloid')
  Rails.logger.info 'Default categories created!'
end

# FACT TYPE RELATED SEED
if FactType.count != 0
  Rails.logger.info 'There are fact types already...'
else
  FactType.create!(name: 'Television')
  FactType.create!(name: 'Radio')
  FactType.create!(name: 'Newspaper')
  FactType.create!(name: 'Business')
  FactType.create!(name: 'Immigration')
  FactType.create!(name: 'Environment')
  FactType.create!(name: 'Intl. Policy')
  FactType.create!(name: 'World')
  FactType.create!(name: 'U.S.')
  FactType.create!(name: 'Politics')
  FactType.create!(name: 'Business')
  FactType.create!(name: 'Opinion')
  FactType.create!(name: 'Technology')
  FactType.create!(name: 'Science')
  FactType.create!(name: 'Health')
  FactType.create!(name: 'Sports')
  FactType.create!(name: 'Arts')
  FactType.create!(name: 'Style')
  FactType.create!(name: 'Food')
  FactType.create!(name: 'Travel')
  FactType.create!(name: 'Magazine')
  FactType.create!(name: 'Real State')
  Rails.logger.info 'Default fact types created!'
end

# TOPIC RELATED SEED
if Topic.count != 0
  Rails.logger.info 'There are topics already...'
else
  Topic.create!(name: 'Surreal')
  Topic.create!(name: 'Action')
  Topic.create!(name: 'Adventure')
  Topic.create!(name: 'Comedy')
  Topic.create!(name: 'Crime')
  Topic.create!(name: 'Drama')
  Topic.create!(name: 'Fantasy')
  Topic.create!(name: 'Historical')
  Topic.create!(name: 'Horror')
  Topic.create!(name: 'Mystery')
  Topic.create!(name: 'Paranoid')
  Topic.create!(name: 'Philosophy')
  Topic.create!(name: 'Political')
  Topic.create!(name: 'Romance')
  Topic.create!(name: 'Saga')
  Topic.create!(name: 'Satire')
  Topic.create!(name: 'Science')
  Topic.create!(name: 'Thriller')
  Topic.create!(name: 'Urban')
  Topic.create!(name: 'Western')
  Topic.create!(name: 'Vocaloid')
  Rails.logger.info 'Default topics created!'
end

# POST RELATED SEED
if Post.count != 0
  Rails.logger.info 'There are posts already...'
else
  # Post Relationships
  songCategory = Category.find_by name: 'song'
  mikuTopic = Topic.find_by name: 'vocaloid'
  technologyFactType = FactType.find_by name: 'technology'
  firstUser = User.first
  Post.create!(fact_link: 'https://en.wikipedia.org/wiki/Hatsune_Miku',
    fiction_link: 'http://www.cbsnews.com/news/hatsune-miku-the-worlds-fakest-pop-star/',
    text: '<h5>Miku is love! Miku is Life!</h5> <p>No seriously, Miku is the result of how community driven creativity can bring a virtual being into real life.</p><p> The Fiction article talks about Miku being a fake persona or a simple program, but if you ask the Vocaloid community, you will hear quite the different tale. Miku is not the only Vocaloid, but she is the logo of how community driven content management can not only bring people closer, but also breath life into a character that represents most of the Vocaloid community (as in all the people who have respect for her in an I-thou interpersonal relation.)</p><ol><li>Do you agree that virtual being can attain the status of real due to the breath of life given by a community behind him/her?</li><li>If not, then what would be required to allow those virtual beings being cosidered real?</li></ol>',
    title: 'The concept of reality behind Hatsune Miku',
    fact_type_id: technologyFactType.id,
    topic_id: mikuTopic.id,
    user_id: firstUser.id,
    category_id: songCategory.id)
end
