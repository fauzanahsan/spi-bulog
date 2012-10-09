class CreatePkptWorkPlans < ActiveRecord::Migration
  def up
    create_table :pkpt_work_plans do |t|
      t.references :pkpt
      t.references :work_plan
      
      t.timestamps
    end
    add_index(:pkpt_work_plans, [:pkpt_id, :work_plan_id])
  end
  
  def down
    drop_table :pkpt_work_plans
  end
end
