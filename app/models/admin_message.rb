class AdminMessage < ActiveRecord::Base  
  validates :title, presence: true
  validates :message, presence: true
  belongs_to :user
end
