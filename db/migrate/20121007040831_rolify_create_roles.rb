class RolifyCreateRoles < ActiveRecord::Migration
  def up
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true
      t.string :keterangan
      
      t.timestamps
    end

    create_table(:admin_users_roles, :id => false) do |t|
      t.references :admin_user
      t.references :role
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:admin_users_roles, [ :admin_user_id, :role_id ])
  end
  
  def down
    drop_table :roles
    drop_table :admin_users_roles
  end
end
