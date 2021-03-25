class CreateSearchAreas < ActiveRecord::Migration[6.1]
  def change
    create_table :search_areas do |t|
      t.string :shape, null: false
      t.string :coordinates, null: false
      t.references :character, null: false, foreign_key: true
      t.references :level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
