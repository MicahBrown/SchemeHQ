class CreateDisucssionEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :disucssion_entries do |t|

      t.timestamps
    end
  end
end
