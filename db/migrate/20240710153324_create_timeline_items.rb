class CreateTimelineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :timeline_items do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
