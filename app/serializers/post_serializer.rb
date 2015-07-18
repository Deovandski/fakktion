class PostSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :genre_id,
             :topic_id,
             :categorie_id,
             :fact_type_id,
             :fact_link,
             :fiction_link,
             :title,
             :importance, 
             :soft_delete,
             :soft_delete_date,
             :hidden,
				 :views_count,
				 :text;
end
