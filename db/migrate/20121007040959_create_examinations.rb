class CreateExaminations < ActiveRecord::Migration
  def up
    create_table :examinations do |t|
      t.references :lhp
      t.string :uraian, :default => ""
      t.string :rekomendasi, :default => ""
      t.string :tanggapan, :default => ""
      t.string :status, :default => "Diinput"

      t.timestamps
    end
    add_index :examinations, :lhp_id
  end
  
  def down
    drop_table :examinations
  end
end
