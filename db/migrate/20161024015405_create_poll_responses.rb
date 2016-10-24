class CreatePollResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :poll_responses do |t|

      t.timestamps
    end
  end
end
