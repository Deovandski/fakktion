class CreateBlog < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :full_name
      t.string :display_name
      t.string :email
      t.string :password_digest
      t.date :date_of_birth
      t.integer :gender
      t.integer :facebook_id
      t.string :twitter_url
      t.string :personal_message
      t.string :webpage_url
      t.boolean :is_banned
      t.date :is_banned_date
      t.integer :number_of_posts
      t.integer :number_of_comments
      t.boolean :legal_terms_read
      t.boolean :privacy_terms_read
      t.boolean :is_admin
      t.timestamps
    end
 
    create_table :comments do |t|
      t.boolean :soft_delete
      t.date :soft_delete_date
      t.string :text
      t.boolean :hidden
      t.integer :empathy_level
      t.timestamps
    end
 
    create_table :posts do |t|
      t.string :fact_link
      t.string :fiction_link
      t.string :post_name
      t.integer :importance
      t.boolean :soft_delete
      t.date :soft_delete_date
      t.boolean :hidden
      t.timestamps
    end
    
    create_table :admin_messages do |t|
      t.string :title
      t.string :message
      t.timestamps
    end
  end  
  
  def down
    drop_table :users
    drop_table :comments
    drop_table :posts
    drop_table :admin_messages
  end
end
