class ChangeAttributInfoOnLhp < ActiveRecord::Migration
  def up
    remove_column :examinations, :uraian
    remove_column :examinations, :rekomendasi
    remove_column :examinations, :tanggapan
    add_column :examinations, :uraian, :text, :default => ""
    add_column :examinations, :rekomendasi, :text, :default => ""
    add_column :examinations, :tanggapan, :text, :default => ""
    add_column :examinations, :tindak_lanjut, :text, :default => ""
  end

  def down
    remove_column :examinations, :uraian
    remove_column :examinations, :rekomendasi
    remove_column :examinations, :tanggapan
    add_column :examinations, :uraian, :string, :default => ""
    add_column :examinations, :rekomendasi, :string, :default => ""
    add_column :examinations, :tanggapan, :string, :default => ""
    remove_column :examinations, :tindak_lanjut
  end
end
