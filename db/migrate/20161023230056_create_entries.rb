class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.belongs_to :scheme, null: false
      t.references :schemable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
