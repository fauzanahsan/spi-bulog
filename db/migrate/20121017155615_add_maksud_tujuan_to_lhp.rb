class AddMaksudTujuanToLhp < ActiveRecord::Migration
  def up
    remove_column :lhps, :program_pemeriksaan
    add_column :lhps, :program_pemeriksaan, :text, :default => ""
    add_column :lhps, :maksud_tujuan, :text, :default => ""
  end
  
  def down
    remove_column :lhps, :program_pemeriksaan
    add_column :lhps, :program_pemeriksaan, :string, :default => ""
    remove_column :lhps, :maksud_tujuan, :text, :default => ""
  end
  
end
