class AddPendahuluanPenutupToLhp < ActiveRecord::Migration
  def up
    add_column :lhps, :pendahuluan, :text, :default => ""
    add_column :lhps, :penutup, :text, :default => ""
  end
  
  def down
    remove_column :lhps, :pendahuluan
    remove_column :lhps, :penutup
  end
end
