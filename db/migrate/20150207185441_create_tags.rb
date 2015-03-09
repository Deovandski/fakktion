class CreateTags < ActiveRecord::Migration
  def up
    create_table :posting_dates do |t|
      t.date :post_date
    end
    
    create_table :categories do |t|
      t.string :category_name
      t.timestamps
    end
  
    create_table :genres do |t|
      t.string :genre_name
      t.timestamps
    end
    
    create_table :topics do |t|
      t.string :topic_name
      t.timestamps
    end
    
    create_table :fact_types do |t|
      t.string :fact_name
      t.timestamps
    end
  end
  
  def down
    drop_table :posting_dates
    drop_table :categories
    drop_table :genres
    drop_table :topics
    drop_table :fact_types
  end
end
