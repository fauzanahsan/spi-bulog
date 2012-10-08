class CreateEntities < ActiveRecord::Migration
  def up
    create_table :entities do |t|
      t.string :kota, :default => ""
      t.string :alamat, :default => ""
      t.string :phone, :default => ""
      t.string :fax, :default => ""
      t.string :status, :default => ""
      t.string :keterangan, :default => ""
      t.string :direktur, :default => ""
      t.string :kecamatan, :default => ""
      t.string :kabupaten, :default => ""
      t.string :provinsi, :default => ""
      
      t.timestamps
    end
  end
  
  def down
    drop_table :entities
  end
end
