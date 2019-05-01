class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
    	t.string "name"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.integer "coin_id"
	    t.string "displayname"
	    t.string "slug"
	    t.index ["slug"], name: "index_genres_on_slug", unique: true
    end
  end
end
