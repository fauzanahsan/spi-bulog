class CreateLhps < ActiveRecord::Migration
  def change
    create_table :lhps do |t|

      t.timestamps
    end
  end
end
