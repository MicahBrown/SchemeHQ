class CreateDiscussionEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :discussion_entries do |t|

      t.timestamps
    end
  end
end
