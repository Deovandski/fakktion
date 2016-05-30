# Create Blog Migration
class CreateBlog < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :full_name
      t.string :display_name
      t.string :facebook_url, default: ""
      t.string :twitter_url, default: ""
      t.string :personal_message, default: ""
      t.string :webpage_url, default: ""
      t.date :date_of_birth
      t.integer  :admin_messages_count, default: 0
      t.integer  :reputation, default: 0
      t.integer  :posts_count, default: 0
      t.integer  :comments_count, default: 0
      t.boolean :legal_terms_read, default: false
      t.boolean :privacy_terms_read, default: false
      t.boolean :is_admin, default: false
      t.boolean :is_super_user, default: false
      t.boolean :is_legend, default: false
      t.boolean :show_full_name, default: false
      t.timestamps null: false
    end
 
    create_table :comments do |t|
      t.string :text
      t.integer :empathy_level, default: 0
      t.integer  :inner_comments_count, default: 0
      t.timestamps null: false
    end
 
    create_table :inner_comments do |t|
      t.string :text
      t.integer :empathy_level, default: 0
      t.timestamps null: false
    end
    
    create_table :posts do |t|
      t.string :fact_link
      t.string :fiction_link
      t.string :title
      t.string :text
      t.integer  :comments_count, default: 0
      t.integer  :views_count, default: 0
      t.timestamps null: false
    end
    
    create_table :admin_messages do |t|
      t.string :title
      t.string :message
      t.timestamps null: false
    end
  end  
  
  def down
    drop_table :users
    drop_table :comments
    drop_table :inner_comments
    drop_table :posts
    drop_table :admin_messages
  end
end
