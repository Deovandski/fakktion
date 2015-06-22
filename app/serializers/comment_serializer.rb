class CommentSerializer < ActiveModel::Serializer
  
  attributes :id,
             :soft_delete,
             :soft_delete_date,
             :text,
             :hidden,
             :empathy_level
end
