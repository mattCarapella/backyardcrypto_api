class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
    	t.text "content"
	    t.datetime "date"
	    t.integer "coin_id"
	    t.integer "user_id"
	    t.boolean "accepted", default: false
	    t.integer "upvotes", default: 0
	    t.integer "downvotes", default: 0
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.string "link"
	    t.string "picture"
	    t.time "time"
	    t.string "city"
	    t.string "state"
	    t.string "country"
	    t.text "description"
	    t.boolean "rejected", default: false
	    t.boolean "pending", default: true
	    t.datetime "start_time"
	    t.datetime "end_time"
	    t.string "venue"
	    t.string "street_address"
	    t.float "latitude"
	    t.float "longitude"
	    t.string "zipcode"
	    t.datetime "deleted_at"
    end
  end
end
