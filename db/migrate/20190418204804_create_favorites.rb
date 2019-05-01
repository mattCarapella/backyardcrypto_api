class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
    	t.integer "coin_id"
	    t.integer "user_id"
	    t.integer "question_id"
	    t.integer "event_id"
	    t.integer "post_id"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
    end
  end
end
