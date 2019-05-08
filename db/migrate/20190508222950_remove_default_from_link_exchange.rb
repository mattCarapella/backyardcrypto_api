class RemoveDefaultFromLinkExchange < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :links, :exchange, nil
  end
end
