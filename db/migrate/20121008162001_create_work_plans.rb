class CreateWorkPlans < ActiveRecord::Migration
  def up
    create_table :work_plans do |t|
      t.references :work_plan_category
      t.references :pkpt
      t.references :team
      t.text :description, :default => ""
      t.text :catatan_pengembalian, :default => ""
      t.datetime :tanggal_proses
      t.string :status, :default => "Diinput"
      
      t.timestamps
    end
    add_index(:work_plans, [ :work_plan_category_id, :pkpt_id, :team_id ], :name => "work_plan_cat_lhp_team")
  end
  
  def down
    drop_table :work_plans
  end
end
