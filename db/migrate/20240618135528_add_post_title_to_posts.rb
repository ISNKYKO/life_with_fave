class AddPostTitleToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :post_title, :string
  end
end
