class AddKeteranganIntoRole < ActiveRecord::Migration
  def up
    add_column    :roles, :keterangan, :string, :default => ""
  end

  def down
    remove_column    :roles, :keterangan
  end
end
