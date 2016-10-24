class CreatePollResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :poll_responses do |t|
      t.belongs_to :user,        null: false
      t.belongs_to :poll,        null: false
      t.belongs_to :poll_option, null: false
      t.timestamps               null: false
    end
  end
end
