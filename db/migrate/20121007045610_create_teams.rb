class CreateTeams < ActiveRecord::Migration
  def up
    create_table :teams do |t|
      t.string :name, :default => ""
      t.string :membership_type, :default => ""
      t.timestamps
    end
  end
  
  def down
    drop_table :teams
  end
end
