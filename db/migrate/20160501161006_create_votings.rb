# Create Voting System to track Posts, Comments, and Inner Comments votes.
class CreateVotings < ActiveRecord::Migration
  def up
    create_table :comment_votes do |t|
      t.boolean  :positive_vote
    end
    create_table :inner_comment_votes do |t|
      t.boolean  :positive_vote
    end
    # Add relationships to the tags tables.
    add_reference :comment_votes, :user, index: true
    add_reference :inner_comment_votes, :user, index: true
    add_reference :comment_votes, :comment, index: true
    add_reference :inner_comment_votes, :inner_comment, index: true
  end
  def down
    remove_reference :comment_votes, :user, index: true
    remove_reference :inner_comment_votes, :user, index: true
    remove_reference :comment_votes, :comment, index: true
    remove_reference :inner_comment_votes, :inner_comments, index: true
    drop_table :comment_votes
    drop_table :inner_comment_votes
  end
end
