class AdminMessageSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :title, :message
end
