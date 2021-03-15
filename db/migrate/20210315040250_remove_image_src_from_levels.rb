class RemoveImageSrcFromLevels < ActiveRecord::Migration[6.1]
  def change
    remove_column :levels, :image_src, :text
  end
end
