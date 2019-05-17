class AddIndexToLinkType < ActiveRecord::Migration[5.2]
  def change
  	add_index :links, :link_type
  end
end
