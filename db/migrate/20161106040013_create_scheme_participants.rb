class CreateSchemeParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :scheme_participants do |t|
      t.belongs_to :user,   null: false
      t.belongs_to :scheme, null: false
      t.string     :role,   null: false, default: 'member' # options: facilitator, mediator, member
      t.timestamps          null: false
    end

    add_index :scheme_participants, [:user_id, :scheme_id], unique: true
  end
end
