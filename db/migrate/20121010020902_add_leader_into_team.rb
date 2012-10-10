class AddLeaderIntoTeam < ActiveRecord::Migration
  def up
    add_column :teams, :leader_id, :int
  end

  def down
    remove_column :teams, :leader_id
  end
end
