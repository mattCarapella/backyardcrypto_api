class AddActiveStatusToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :active_status, :integer, default: 0
  end
end
