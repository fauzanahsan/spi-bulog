class CreateLhpExaminations < ActiveRecord::Migration
  def up
    create_table :lhp_examinations do |t|
      t.references :lhp
      t.references :examination
      
      t.timestamps
    end
    add_index(:lhp_examinations, [:lhp_id, :examination_id])
  end
  
  def down
    drop_table :lhp_examinations
  end
end
