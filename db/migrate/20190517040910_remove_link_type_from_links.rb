class RemoveLinkTypeFromLinks < ActiveRecord::Migration[5.2]
  def change
  	remove_column :links, :link_type
  end
end
