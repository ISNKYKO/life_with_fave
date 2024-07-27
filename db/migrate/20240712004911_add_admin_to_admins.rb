class AddAdminToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :admin, :boolean, default: false
  end
end
