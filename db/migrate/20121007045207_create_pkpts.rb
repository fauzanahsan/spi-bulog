class CreatePkpts < ActiveRecord::Migration
  def up
    create_table :pkpts do |t|
      t.string :keterangan_awal, :default => ""
      t.datetime :periode
      t.string :status, :default => ""
      
      t.timestamps
    end
  end
  
  def down
    drop_table :pkpts
  end
end
