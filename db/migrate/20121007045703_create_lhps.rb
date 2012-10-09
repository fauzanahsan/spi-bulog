class CreateLhps < ActiveRecord::Migration
  def up
    create_table :lhps do |t|
      t.references :entity
      t.string :keterangan, :default => ""
      t.string :pre_keterangan, :default => ""
      t.string :post_keterangan, :default => ""
      t.datetime :tanggal_awal
      t.datetime :tanggal_akhir
      t.string :program_pemeriksaan, :default => ""
      t.string :status, :default => ""
      
      t.timestamps
    end
    add_index :lhps, :entity_id
  end
  
  def down
    drop_table :lhps
  end
end
