class FactPostingSerializer < ActiveModel::Serializer
  has_many :posts
  attributes :id, :fact_post_date
end
