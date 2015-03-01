class FactTypeSerializer < ActiveModel::Serializer
  has_many :posts
  
  embed :ids, include: true
  
  attributes :id,
             :fact_name
end
