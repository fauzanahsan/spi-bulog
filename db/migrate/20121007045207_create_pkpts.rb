class CreatePkpts < ActiveRecord::Migration
  def up
    create_table :pkpts do |t|
      t.references :entity
      t.string :keterangan_awal, :default => ""
      t.datetime :periode
      t.string :status, :default => ""
      
      t.timestamps
    end
    add_index :pkpts, :entity_id
  end
  
  def down
    drop_table :pkpts
  end
end
