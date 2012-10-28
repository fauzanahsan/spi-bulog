class AddKeteranganToLhp < ActiveRecord::Migration
  def up
    remove_column :lhps, :keterangan
    add_column :lhps, :keterangan, :text, :default => ""
  end
  
  def down
    remove_column :lhps, :keterangan
    add_column :lhps, :keterangan, :string, :default => ""
  end
end
