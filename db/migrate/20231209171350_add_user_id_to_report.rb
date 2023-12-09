class AddUserIdToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :user_id, :integer
    add_foreign_key :reports, :users, column: :user_id
  end
end
