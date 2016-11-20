class CreateDiscussionParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :discussion_participants do |t|
      t.belongs_to :user,       null: false
      t.belongs_to :discussion, null: false
      t.string     :role,       null: false, default: 'member' # options: facilitator, mediator, member
      t.timestamps              null: false
    end

    add_index :discussion_participants, [:user_id, :discussion_id], unique: true
  end
end
