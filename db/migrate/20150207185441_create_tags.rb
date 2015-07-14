class CreateTags < ActiveRecord::Migration
    create_table :categories do |t|
      t.string :name
      t.integer  :usage_count, default: 0
      t.timestamps
    end
  
    create_table :genres do |t|
      t.string :name
      t.integer  :usage_count, default: 0
      t.timestamps
    end
    
    create_table :topics do |t|
      t.string :name
      t.integer  :usage_count, default: 0
      t.timestamps
    end
    
    create_table :fact_types do |t|
      t.string :name
      t.integer  :usage_count, default: 0
      t.timestamps
    end
  
  def down
    drop_table :categories
    drop_table :genres
    drop_table :topics
    drop_table :fact_types
  end
end
