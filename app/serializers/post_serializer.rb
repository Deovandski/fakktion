class PostSerializer < ActiveModel::Serializer
  #has_many :comments
  
  #not working
  #belongs_to :genre
  #belongs_to :fact_type
  #belongs_to :topic
  #belongs_to :categorie
  
  attributes :id,
             :user_id,
             :genre_id,
             :topic_id,
             :categorie_id,
             :fact_type_id,
             :fact_link,
             :fiction_link,
             :post_name,
             :importance, 
             :soft_delete,
             :soft_delete_date,
             :hidden
end
