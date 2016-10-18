class CreatePollOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :poll_options do |t|
      t.belongs_to :poll,     null: false
      t.string     :value,    null: false
      t.integer    :position, null: false, default: 0
      t.timestamps            null: false
    end
  end
end
