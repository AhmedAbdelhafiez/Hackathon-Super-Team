class AddUserIdAndAnswerToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :user_id, :integer
    add_column :questions, :answer, :string
    add_foreign_key :questions, :users, column: :user_id
  end
end
