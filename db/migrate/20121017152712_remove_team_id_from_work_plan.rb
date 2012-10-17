class RemoveTeamIdFromWorkPlan < ActiveRecord::Migration
  def up
    remove_column :work_plans, :team_id
  end

  def down
    add_column :work_plans, :team_id, :integer
  end
end
