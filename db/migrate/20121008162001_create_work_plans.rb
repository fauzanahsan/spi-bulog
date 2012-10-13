class CreateWorkPlans < ActiveRecord::Migration
  def up
    create_table :work_plans do |t|
      t.references :work_plan_category
      t.references :lhp
      t.references :team
      t.string :description, :default => ""
      t.string :status, :default => ""
      
      t.timestamps
    end
    add_index(:work_plans, [ :work_plan_category_id, :lhp_id, :team_id ], :name => "work_plan_cat_lhp_team")
  end
  
  def down
    drop_table :work_plans
  end
end
