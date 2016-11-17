class CreateNicknames < ActiveRecord::Migration[5.0]
  def change
    create_table :nicknames do |t|
      t.belongs_to :namer, null: false
      t.belongs_to :namee, null: false
      t.string :value, null: false

      t.timestamps null: false
    end

    add_index :nicknames, [:namer_id, :namee_id], unique: true
  end
end
