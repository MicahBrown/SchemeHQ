class CreateSchemes < ActiveRecord::Migration[5.0]
  def change
    create_table :schemes do |t|
      t.belongs_to :user, null: false
      t.string :title,    null: false
      t.string :token,    null: false
      t.boolean :private, null: false, default: false
      t.timestamps        null: false
    end

    add_index :schemes, :token, unique: true
  end
end
