class AddStatusTindakLanjutToExamination < ActiveRecord::Migration
  def up
    add_column :examinations, :status_tindak_lanjut, :string, :default => ""
  end
  
  def down
    remove_column :examinations, :status_tindak_lanjut
  end
end
