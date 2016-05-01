# Create Tags Migration
class CreateTags < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string   :name
      t.integer  :eligibility_counter, default: 0
      t.integer  :posts_count, default: 0
    end
    create_table :genres do |t|
      t.string   :name
      t.integer  :eligibility_counter, default: 0
      t.integer  :posts_count, default: 0
    end
    create_table :topics do |t|
      t.string   :name
      t.integer  :eligibility_counter, default: 0
      t.integer  :posts_count, default: 0
    end
    create_table :fact_types do |t|
      t.string   :name
      t.integer  :eligibility_counter, default: 0
      t.integer  :posts_count, default: 0
    end
    # Add relationships to the tags tables.
    add_reference :posts, :user, index: true
    add_reference :posts, :fact_type, index: true
    add_reference :posts, :genre, index: true
    add_reference :posts, :topic, index: true
    add_reference :posts, :category, index: true
    add_reference :comments, :post, index: true
    add_reference :comments, :user, index: true
    add_reference :inner_comments, :comment, index: true
    add_reference :inner_comments, :user, index: true
    add_reference :admin_messages, :user, index: true
  end
  def down
    remove_reference :posts, :user, index: true
    remove_reference :posts, :fact_type, index: true
    remove_reference :posts, :genre, index: true
    remove_reference :posts, :topic, index: true
    remove_reference :posts, :category, index: true
    remove_reference :comments, :post, index: true
    remove_reference :comments, :user, index: true
    remove_reference :inner_comments, :comment, index: true
    remove_reference :inner_comments, :user, index: true
    remove_reference :admin_messages, :user, index: true
    drop_table :categories
    drop_table :genres
    drop_table :topics
    drop_table :fact_types
  end
end
