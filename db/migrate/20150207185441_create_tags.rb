# Create Tags Migration
class CreateTags < ActiveRecord::Migration
    create_table :categories do |t|
      t.string	 :name
      t.integer  :posts_count, default: 0
    end
  
    create_table :genres do |t|
      t.string	 :name
      t.integer  :eligibility_counter, default: 0
      t.integer  :posts_count, default: 0
    end
    
    create_table :topics do |t|
      t.string	 :name
      t.integer  :eligibility_counter, default: 0
      t.integer  :posts_count, default: 0
    end
    
    create_table :fact_types do |t|
      t.string	 :name
      t.integer  :eligibility_counter, default: 0
      t.integer  :posts_count, default: 0
    end
  
  def down
    drop_table :categories
    drop_table :genres
    drop_table :topics
    drop_table :fact_types
  end
end
