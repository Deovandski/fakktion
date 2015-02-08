class CreateRelationships < ActiveRecord::Migration
  def up
    add_reference :posts, :user, index: true
    add_reference :posts, :fact_type, index: true
    add_reference :posts, :fact_posting, index: true
    add_reference :posts, :genre, index: true
    add_reference :posts, :topic, index: true
    add_reference :posts, :categorie, index: true
    add_reference :comments, :post, index: true
    add_reference :comments, :user, index: true
    add_reference :admin_messages, :user, index: true
  end
  
  def down
    remove_reference :posts, :user, index: true
    remove_reference :posts, :fact_type, index: true
    remove_reference :posts, :fact_posting, index: true
    remove_reference :posts, :genre, index: true
    remove_reference :posts, :topic, index: true
    remove_reference :posts, :categorie, index: true
    remove_reference :comments, :post, index: true
    remove_reference :comments, :user, index: true
    remove_reference :admin_messages, :user, index: true
  end
end
