class AddLinkTypeToLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :link_type, :integer
  end
end
