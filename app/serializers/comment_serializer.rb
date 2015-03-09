class CommentSerializer < ActiveModel::Serializer
  
  embed :ids, include: true
  
  attributes :id,
             :soft_delete,
             :soft_delete_date,
             :text,
             :hidden,
             :empathy_level
end
