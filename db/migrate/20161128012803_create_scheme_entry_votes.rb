class CreateSchemeEntryVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :scheme_entry_votes do |t|

      t.timestamps
    end
  end
end
