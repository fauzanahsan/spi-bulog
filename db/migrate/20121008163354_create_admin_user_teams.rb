class CreateAdminUserTeams < ActiveRecord::Migration
  def up
    create_table :admin_user_teams do |t|
      t.references :admin_user
      t.references :team
    end
    add_index(:admin_user_teams, [ :admin_user_id, :team_id ])
  end
  
  def down
    drop_table :admin_user_teams
  end
  
end
