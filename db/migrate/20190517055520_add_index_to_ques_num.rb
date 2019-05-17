class AddIndexToQuesNum < ActiveRecord::Migration[5.2]
  def change
  	add_index :questions, :ques_num
  end
end
