class CreatePkpts < ActiveRecord::Migration
  def change
    create_table :pkpts do |t|

      t.timestamps
    end
  end
end
