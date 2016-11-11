class CreateDiscussionInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :discussion_invitations do |t|
      t.integer    :user_id,    null: false, default: 0
      t.belongs_to :discussion, null: false
      t.string     :email,      null: false
      t.datetime   :sent_at
      t.datetime   :accepted_at
      t.timestamps              null: false
    end

    add_index :discussion_invitations, :user_id
    add_index :discussion_invitations, [:discussion_id, :email], unique: true
  end
end
