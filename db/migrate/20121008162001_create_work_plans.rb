class CreateWorkPlans < ActiveRecord::Migration
  def up
    create_table :work_plans do |t|
      t.references :work_plans_category
      t.string :description, :default => ""
      t.string :status, :default => ""
      
      t.timestamps
    end
    add_index :work_plans, :work_plans_category_id
  end
  
  def down
    drop_table :work_plans
  end
end
