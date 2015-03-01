class CategorieSerializer < ActiveModel::Serializer
  has_many :posts
  
  embed :ids, include: true
  
  attributes :id,
             :category_name
end
