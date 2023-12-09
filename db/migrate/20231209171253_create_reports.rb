class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.json :content

      t.timestamps
    end
  end
end
