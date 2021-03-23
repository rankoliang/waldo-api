class ChangeSecondsForScores < ActiveRecord::Migration[6.1]
  def change
    change_column :scores, :seconds, :integer
    rename_column :scores, :seconds, :milliseconds
  end
end
