class CreateSchemeEntryVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :scheme_entry_votes do |t|
      t.belongs_to :user,         null: false
      t.belongs_to :scheme_entry, null: false
      t.integer    :value,        null: false, limit: 2
      t.timestamps                null: false
    end

    add_index :scheme_entry_votes, [:user_id, :scheme_entry_id], unique: true
  end
end