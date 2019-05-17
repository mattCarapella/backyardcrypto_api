class AddActiveStatusToTerms < ActiveRecord::Migration[5.2]
  def change
    add_column :terms, :active_status, :integer, default: 0
    add_column :key_players, :active_status, :integer, default: 0
    add_column :events, :active_status, :integer, default: 0
    add_column :links, :active_status, :integer, default: 0
    add_column :pictures, :active_status, :integer, default: 0
  end
end
