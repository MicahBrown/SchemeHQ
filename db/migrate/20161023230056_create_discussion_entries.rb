class CreateDiscussionEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :discussion_entries do |t|
      t.belongs_to :discussion, null: false
      t.references :discussable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
