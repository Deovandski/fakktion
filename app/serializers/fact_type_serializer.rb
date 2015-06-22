class FactTypeSerializer < ActiveModel::Serializer
  #has_many :posts
  
  attributes :id,
             :fact_name
end
