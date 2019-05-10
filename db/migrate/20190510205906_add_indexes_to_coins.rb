class AddIndexesToCoins < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :coin_id
  	add_index :links, :coin_id
  	add_index :questions, :coin_id
  end
end
