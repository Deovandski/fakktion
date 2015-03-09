class PostingDateSerializer < ActiveModel::Serializer
  #has_many :posts
  
  embed :ids, include: true
  
  attributes :id,
             :post_date
end
