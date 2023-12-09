class AddQuestionOffsetToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :question_offset, :integer, :null => false, :default => 1
  end
end
