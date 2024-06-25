class RenamePostImageColumnToFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :post_image_id, :post_id
  end
end
