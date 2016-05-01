# Post Serializer
class PostSerializer < ActiveModel::Serializer
  attributes  :fact_link,
              :fiction_link,
              :title,
              :hidden,
              :views_count,
              :text,
              :comments_count,
              :created_at,
              :updated_at,
               # The direct ids used on Index filter matching methodology
               # has been choosen due to how complex it can become when attempting
               # to use DS.BelongsTo(). See Ember Data #1865 for more info...
              :genre_id,
              :category_id,
              :topic_id,
              :fact_type_id,
              :user_id

  # Relationships
  has_many :comments
  belongs_to :genre
  belongs_to :fact_type
  belongs_to :category
  belongs_to :topic
  belongs_to :user
end
