class ChangeTelephoneNumberToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :telephone_number, :string, null: false
  end
end
