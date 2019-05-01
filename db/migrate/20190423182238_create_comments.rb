class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
    	t.integer "post_id"
	    t.text "body"
	    t.bigint "user_id"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.string "commentable_type"
	    t.bigint "commentable_id"
	    t.integer "parent_id"
	    t.integer "upvotes", default: 0
	    t.integer "downvotes", default: 0
	    t.float "approval_rating", default: 0.0
	    t.boolean "deleted", default: false
	    t.boolean "edited", default: false
	    t.bigint "coin_id"
	    t.datetime "deleted_at"
	    t.integer "depth", default: 0
	    t.index ["coin_id"], name: "index_comments_on_coin_id"
	    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
	    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
	    t.index ["post_id"], name: "index_comments_on_post_id"
	    t.index ["user_id"], name: "index_comments_on_user_id"
    end
  end
end
