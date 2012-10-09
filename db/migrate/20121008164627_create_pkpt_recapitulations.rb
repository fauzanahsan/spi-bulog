class CreatePkptRecapitulations < ActiveRecord::Migration
  def up
    create_table :pkpt_recapitulations do |t|
      t.references :pkpt
      t.string :keterangan_pembuka
      t.string :keterangan_penutup
      
      t.timestamps
    end
    
    add_index :pkpt_recapitulations, :pkpt_id
  end
  
  def down
    drop_table :pkpt_recapitulations
  end
end
