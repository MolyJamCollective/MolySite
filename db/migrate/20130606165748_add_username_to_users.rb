class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, default: "", null: false, unique: true
  end
end
