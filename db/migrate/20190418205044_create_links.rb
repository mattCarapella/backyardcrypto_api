class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
    	t.string "url"
	    t.integer "coin_id"
	    t.integer "user_id"
	    t.boolean "accepted", default: false
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.string "websitename"
	    t.string "tag"
	    t.string "link_type"
	    t.boolean "rejected", default: false
	    t.boolean "pending", default: true
	    t.boolean "exchange", default: false
	    t.text "description"
	    t.datetime "deleted_at"
	    t.index ["deleted_at"], name: "index_links_on_deleted_at"
    end
  end
end
