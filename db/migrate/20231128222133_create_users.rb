class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :country
      t.string :company
      t.integer :size
      t.string :title
      t.string :idea
      t.string :source
      t.string :experience
      t.timestamps
    end
  end
end
