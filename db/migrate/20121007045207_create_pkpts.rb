class CreatePkpts < ActiveRecord::Migration
  def up
    create_table :pkpts do |t|
      t.references :entity
      t.string :keterangan, :default => ""
      t.string :periode
      t.string :status, :default => "Diinput"
      t.string :created_by, :default => ""
      t.string :updated_by, :default => ""
      t.string :accepted_by, :default => ""
      t.string :rejected_by, :default => ""
      t.datetime :accepted_at
      t.datetime :rejected_at
      t.integer :tipe, :default => 0
      t.text :catatan_pengembalian, :default => ""
      
      t.timestamps
    end
    add_index :pkpts, :entity_id
  end
  
  def down
    drop_table :pkpts
  end
end
