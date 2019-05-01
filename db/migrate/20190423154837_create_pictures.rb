class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
    	t.string "image"
	    t.bigint "coin_id"
	    t.bigint "user_id"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.boolean "accepted", default: false
	    t.boolean "rejected", default: false
	    t.boolean "pending", default: true
	    t.string "description"
	    t.index ["coin_id"], name: "index_pictures_on_coin_id"
	    t.index ["user_id"], name: "index_pictures_on_user_id"
    end
  end
end
