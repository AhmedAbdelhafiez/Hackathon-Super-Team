class AddForeignKeysToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :user_id, :integer
    add_column :answers, :question_id, :integer

    add_foreign_key :answers, :users, column: :user_id
    add_foreign_key :answers, :questions, column: :question_id
  end
end
