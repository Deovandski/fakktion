class GenreSerializer < ActiveModel::Serializer
  has_many :posts
  
  embed :ids, include: true
  
  attributes :id,
             :genre_name
end
