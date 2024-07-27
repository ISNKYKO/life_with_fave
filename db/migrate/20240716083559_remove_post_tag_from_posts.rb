class RemovePostTagFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :post_tag, :integer
  end
end
