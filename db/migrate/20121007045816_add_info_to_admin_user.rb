class AddInfoToAdminUser < ActiveRecord::Migration
  def up
    add_column :admin_users, :phone,  :string, :default => ""
    add_column :admin_users, :fullname,  :string, :default => ""
  end
  
  def down
    remove_column :admin_users, :phone,  :string, :default => ""
    remove_column :admin_users, :fullname,  :string, :default => ""
  end
end
