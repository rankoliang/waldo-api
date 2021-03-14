class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :shape, null: false
      t.string :coordinates, null: false
      t.references :level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
