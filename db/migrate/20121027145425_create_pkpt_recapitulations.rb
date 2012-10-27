class CreatePkptRecapitulations < ActiveRecord::Migration
  def up
    create_table :pkpt_recapitulations do |t|
      t.references :pkpt
      t.references :recapitulation
      
      t.timestamps
    end
    
    add_index(:pkpt_recapitulations, [:pkpt_id, :recapitulation_id])
  end
  
  def down
    drop_table :pkpt_recapitulations
  end
end
