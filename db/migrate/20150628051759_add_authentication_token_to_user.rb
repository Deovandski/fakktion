# Add AuthenticationToken to User Migration
class AddAuthenticationTokenToUser < ActiveRecord::Migration
	def up
		add_column :users, :authentication_token, :string
	end

	def down
		remove_column :users, :authentication_token, :string
	end
end
