class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user,       null: false
      t.belongs_to :discussion, null: false
      t.text :message,          null: false
      t.timestamps              null: false
    end
  end
end
