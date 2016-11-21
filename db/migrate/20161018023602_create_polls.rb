class CreatePolls < ActiveRecord::Migration[5.0]
  def change
    create_table :polls do |t|
      t.belongs_to :user,     null: false
      t.belongs_to :scheme,   null: false
      t.string     :title,    null: false
      t.datetime   :locked_at
      t.timestamps            null: false
    end
  end
end
