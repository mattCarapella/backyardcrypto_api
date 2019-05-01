class CreateFlags < ActiveRecord::Migration[5.2]
  def change
    create_table :flags do |t|
    	t.bigint "user_id"
	    t.bigint "question_id"
	    t.text "reason_for_flag"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.bigint "post_id"
	    t.bigint "coin_id"
	    t.index ["coin_id"], name: "index_flags_on_coin_id"
	    t.index ["post_id"], name: "index_flags_on_post_id"
	    t.index ["question_id"], name: "index_flags_on_question_id"
	    t.index ["user_id"], name: "index_flags_on_user_id"
    end
  end
end
