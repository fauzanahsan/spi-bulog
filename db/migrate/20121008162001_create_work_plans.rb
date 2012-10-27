class CreateWorkPlans < ActiveRecord::Migration
  def up
    create_table :work_plans do |t|
      t.references :work_plan_category
      t.references :pkpt
      t.references :team
      t.text :description, :default => ""
      t.text :catatan_pengembalian, :default => ""
      t.string :status, :default => "Diinput"
      t.string :created_by, :default => ""
      t.string :updated_by, :default => ""
      t.string :accepted_by, :default => ""
      t.string :rejected_by, :default => ""
      t.datetime :accepted_at
      t.datetime :rejected_at
      
      t.timestamps
    end
    add_index(:work_plans, [ :work_plan_category_id, :pkpt_id, :team_id ], :name => "work_plan_cat_lhp_team")
  end
  
  def down
    drop_table :work_plans
  end
end
