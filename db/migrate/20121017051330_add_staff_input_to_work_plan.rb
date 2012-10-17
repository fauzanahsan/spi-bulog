class AddStaffInputToWorkPlan < ActiveRecord::Migration
  def up
    add_column :work_plans, :staff_input,  :string, :default => ""
  end
  
  def down
    remove_column :work_plans, :staff_input
  end
end
