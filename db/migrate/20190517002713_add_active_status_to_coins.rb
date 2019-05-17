class AddActiveStatusToCoins < ActiveRecord::Migration[5.2]
  def change
    add_column :coins, :active_status, :integer, default: 0
  end
end
