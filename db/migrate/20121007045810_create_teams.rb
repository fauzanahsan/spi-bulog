class CreateTeams < ActiveRecord::Migration
  def up
    create_table :teams do |t|
      t.references :work_plan
      t.string :name, :default => ""
      t.timestamps
    end
    add_index :teams, :work_plan_id
  end
  
  def down
    drop_table :teams
  end
end
