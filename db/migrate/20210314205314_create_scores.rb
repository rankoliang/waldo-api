class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.references :level, null: false, foreign_key: true
      t.string :name, null: false, default: 'Anonymous'
      t.decimal :seconds, null: false

      t.timestamps
    end
  end
end
