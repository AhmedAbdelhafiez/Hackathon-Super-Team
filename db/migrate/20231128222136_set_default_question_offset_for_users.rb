class SetDefaultQuestionOffsetForUsers < ActiveRecord::Migration[7.0]
  def up
    User.update_all(question_offset: 0)
  end

  def down
    # You can add a down method if needed
  end
end
