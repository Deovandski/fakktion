# PostVote Model
class PostVote < ActiveRecord::Base
  
  # Relationships
  belongs_to :post
  belongs_to :user
end
