class ChangeColumnType < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :telephone_number, :integer
  end
end
