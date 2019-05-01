class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
    	t.text "content"
	    t.string "url"
	    t.string "picture"
	    t.integer "coin_id"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.integer "user_id"
	    t.string "title"
	    t.boolean "edited", default: false
	    t.integer "upvotes", default: 0
	    t.integer "downvotes", default: 0
	    t.float "approval_rating", default: 0.0
	    t.datetime "deleted_at"
	    t.string "post_type"
	    t.integer "post_category"
	    t.index ["deleted_at"], name: "index_posts_on_deleted_at"
    end
  end
end
