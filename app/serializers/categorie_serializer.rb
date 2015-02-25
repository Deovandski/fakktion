class CategorieSerializer < ActiveModel::Serializer
  has_many :posts
  attributes :id, :category_name
end
