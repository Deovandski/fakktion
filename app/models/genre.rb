class Genre < ActiveRecord::Base
	has_many :posts
end
