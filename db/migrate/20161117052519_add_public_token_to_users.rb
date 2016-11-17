class AddPublicTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :public_token, :string, null: false, default: ""
    add_index :users, :public_token, unique: true
  end

end
