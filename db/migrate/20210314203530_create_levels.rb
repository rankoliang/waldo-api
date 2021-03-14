class CreateLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :levels do |t|
      t.string :title, null: false
      t.text :image_src

      t.timestamps
    end
  end
end
