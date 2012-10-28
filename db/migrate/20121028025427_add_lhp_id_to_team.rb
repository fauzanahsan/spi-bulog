class AddLhpIdToTeam < ActiveRecord::Migration
  def up
    remove_column :teams, :work_plan_id
    add_column :teams, :lhp_id, :integer
  end
  
  def down
    add_column :teams, :work_plan_id, :integer
    remove_column :teams, :lhp_id
  end
end
