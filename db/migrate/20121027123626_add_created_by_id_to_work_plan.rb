class AddCreatedByIdToWorkPlan < ActiveRecord::Migration
  def up
    add_column :work_plans, :created_by_id, :integer
  end
  
  def down
    remove_column :work_plans, :created_by_id
  end
end
