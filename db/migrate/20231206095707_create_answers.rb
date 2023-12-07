class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.text :text
      t.vector :embedding, limit: 1536

      t.timestamps
    end
  end
end
