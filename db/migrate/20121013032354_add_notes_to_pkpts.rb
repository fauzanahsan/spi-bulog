class AddNotesToPkpts < ActiveRecord::Migration
  def up
    add_column :pkpts, :notes,  :text, :default => ""
  end
  
  def down
    remove_column :pkpts, :notes
  end
end
