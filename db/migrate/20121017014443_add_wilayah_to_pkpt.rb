class AddWilayahToPkpt < ActiveRecord::Migration
  def up
    add_column :pkpts, :wilayah,  :string, :default => ""
  end
  
  def down
    remove_column :pkpts, :wilayah
  end
end
