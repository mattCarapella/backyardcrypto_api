class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :username, :string 
  	add_column :users, :fname, :string
  	add_column :users, :lname, :string
  	add_column :users, :terms_of_service, :boolean, default: false
  	add_column :users, :wallet, :string
  	add_column :users, :admin, :boolean, default: false
  	add_column :users, :moderator, :boolean, default: false
  	add_column :users, :currentbalance, :decimal 
  	add_column :users, :payout_to_date, :decimal
  	add_column :users, :bio, :text 
  	add_column :users, :facebook, :string 
  	add_column :users, :twitter, :string 
  	add_column :users, :instagram, :string 
  	add_column :users, :linked_in, :string 
  	add_column :users, :youtube, :string 
  	add_column :users, :personal_website, :string 
  	add_column :users, :id_photo, :string 
  end
end
