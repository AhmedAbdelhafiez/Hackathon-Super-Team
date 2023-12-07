class AddStateToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :state, :integer
  end
end
