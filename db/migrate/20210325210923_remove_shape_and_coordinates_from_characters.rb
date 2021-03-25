class RemoveShapeAndCoordinatesFromCharacters < ActiveRecord::Migration[6.1]
  def change
    change_table(:characters) do |t|
      t.remove :shape
      t.remove :coordinates
      t.remove_references :level
    end
  end
end
