class CreateWorkPlanCategories < ActiveRecord::Migration
  def change
    create_table :work_plan_categories do |t|
      t.string :name, :default => ""
      t.string :description, :default => ""
      
      t.timestamps
    end
  end
  
  def down
    drop_table :work_plan_categories
  end
end
