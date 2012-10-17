class AddRencanKerjaDetailToWorkPlan < ActiveRecord::Migration
  def up
    remove_column :work_plans, :description
    add_column :work_plans, :description,  :string, :default => ""
    add_column :work_plans, :work_plan_details,  :text, :default => ""
  end
  
  def down
    remove_column :work_plans, :description
    add_column :work_plans, :description, :text, :default => ""
    remove_column :work_plans, :work_plan_details
  end
end
