class GenreSerializer < ActiveModel::Serializer
  #has_many :posts
  
  attributes :id,
             :genre_name
end
