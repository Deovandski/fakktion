class PostSerializer < ActiveModel::Serializer
  has_many :comments
  #belongs_to :genre
  #belongs_to :fact_type
  #belongs_to :fact_posting
  #belongs_to :topic
  #belongs_to :categorie
  
  attributes :id,
             :fact_link,
             :fiction_link,
             :post_name,
             :importance, 
             :soft_delete,
             :soft_delete_date,
             :hidden
end
