class CreateSchemeInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :scheme_invitations do |t|
      t.integer    :user_id,      null: false, default: 0
      t.belongs_to :scheme,       null: false
      t.string     :email,        null: false
      t.datetime   :sent_at
      t.datetime   :accepted_at
      t.datetime   :responded_at
      t.boolean    :response
      t.timestamps                null: false
    end

    add_index :scheme_invitations, :user_id
    add_index :scheme_invitations, [:scheme_id, :email], unique: true
  end
end
