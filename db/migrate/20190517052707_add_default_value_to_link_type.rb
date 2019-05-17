class AddDefaultValueToLinkType < ActiveRecord::Migration[5.2]
  def up
	  change_column :links, :link_type, :integer, default: 0
	end

	def down
	  change_column :links, :link_type, :integer, default: nil
	end
end
