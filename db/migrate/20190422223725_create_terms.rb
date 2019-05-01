class CreateTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :terms do |t|
			t.string "title"
	    t.text "caption"
	    t.text "content"
	    t.boolean "accepted", default: false
	    t.boolean "pending", default: true
	    t.boolean "rejected", default: false
	    t.string "image"
	    t.text "image_caption"
	    t.string "slug"
	    t.integer "upvotes", default: 0
	    t.integer "downvotes", default: 0
	    t.float "approval_rating", default: 0.0
	    t.datetime "accepted_at"
	    t.bigint "coin_id"
	    t.bigint "user_id"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.text "image_data"
	    t.string "cached_image_data"
	    t.index ["coin_id"], name: "index_terms_on_coin_id"
	    t.index ["user_id"], name: "index_terms_on_user_id"
	  end
  end
end
