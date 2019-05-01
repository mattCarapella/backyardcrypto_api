class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
	    t.integer "ques_num"
	    t.text "content"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.integer "user_id"
	    t.integer "coin_id"
	    t.boolean "accepted", default: false
	    t.datetime "accepted_at"
	    t.string "term"
	    t.text "description"
	    t.boolean "rejected", default: false
	    t.boolean "pending", default: true
	    t.text "caption"
	    t.string "image"
	    t.text "image_caption"
	    t.string "slug"
	    t.string "open_topic"
	    t.integer "upvotes", default: 0
	    t.integer "downvotes", default: 0
	    t.float "approval_rating", default: 0.0
	    t.datetime "deleted_at"
	    t.integer "citation_count", default: 0
    end
  end
end


