class CreateExaminations < ActiveRecord::Migration
  def up
    create_table :examinations do |t|
      t.references :lhp
      t.string :uraian, :default => ""
      t.string :rekomendasi, :default => ""
      t.string :tanggapan, :default => ""
      t.string :status, :default => "Diinput"
      t.string :created_by, :default => ""
      t.string :updated_by, :default => ""
      t.string :accepted_by, :default => ""
      t.string :rejected_by, :default => ""
      t.datetime :accepted_at
      t.datetime :rejected_at
      t.integer :priority
      t.text :catatan_pengembalian, :default => ""
      t.timestamps
    end
    add_index :examinations, :lhp_id
  end
  
  def down
    drop_table :examinations
  end
end
