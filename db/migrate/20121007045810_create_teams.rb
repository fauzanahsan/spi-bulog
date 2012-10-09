class CreateTeams < ActiveRecord::Migration
  def up
    create_table :teams do |t|
      t.references :lhp
      t.string :name, :default => ""
      t.timestamps
    end
    add_index :teams, :lhp_id
  end
  
  def down
    drop_table :teams
  end
end
