class AddPublicTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :public_token, :string, null: false, default: ""

    User.reset_column_information
    User.all.each do |user|
      user.regenerate_public_token
      user.save
    end

    add_index :users, :public_token, unique: true
  end

end
