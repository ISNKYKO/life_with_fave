class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :post
      t.integer :post_tag
      t.integer :states
      t.timestamps
    end
  end
end
