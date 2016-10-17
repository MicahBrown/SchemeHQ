class CreateDiscussions < ActiveRecord::Migration[5.0]
  def change
    create_table :discussions do |t|
      t.belongs_to :user, null: false
      t.string :title,    null: false
      t.boolean :private, null: false, default: false
      t.timestamps        null: false
    end
  end
end
