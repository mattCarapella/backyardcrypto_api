class CreateCoinGenres < ActiveRecord::Migration[5.2]
  def change
  	create_table :coins_genres, :id => false do |t|
      t.integer :coin_id
      t.integer :genre_id
    end
  end
end