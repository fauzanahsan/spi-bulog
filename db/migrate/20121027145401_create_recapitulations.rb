class CreateRecapitulations < ActiveRecord::Migration
  def up
    create_table :recapitulations do |t|
      t.string :periode, :default => ""
      t.text :keterangan_pembuka, :default => ""
      t.text :keterangan_penutup, :default => ""
      t.string :status_rekap, :default => "Belum Rekap"
      
      t.timestamps
    end
  end
  
  def down
    drop_table :recapitulations
  end
end
