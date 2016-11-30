class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.belongs_to :user,         null: false
      t.belongs_to :scheme_entry, null: false
      t.timestamps                null: false
    end

    add_index :favorites, [:user_id, :scheme_entry_id], unique: true
  end
end
