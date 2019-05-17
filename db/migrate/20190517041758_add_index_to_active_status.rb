class AddIndexToActiveStatus < ActiveRecord::Migration[5.2]
  def change
  	add_index :coins, :active_status
  	add_index :events, :active_status
  	add_index :key_players, :active_status
  	add_index :links, :active_status
  	add_index :questions, :active_status
  	add_index :terms, :active_status
  end
end
