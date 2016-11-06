class CreateDiscussionInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :discussion_invitations do |t|

      t.timestamps
    end
  end
end
