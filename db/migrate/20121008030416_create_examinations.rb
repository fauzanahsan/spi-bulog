class CreateExaminations < ActiveRecord::Migration
  def up
    create_table :examinations do |t|
      t.string :uraian, :default => ""
      t.string :rekomendasi, :default => ""
      t.string :tanggapan, :default => ""
      t.string :status, :default => ""

      t.timestamps
    end
  end
  
  def down
    drop_table :examinations
  end
end
