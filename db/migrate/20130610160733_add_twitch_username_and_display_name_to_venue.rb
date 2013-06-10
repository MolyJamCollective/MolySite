class AddTwitchUsernameAndDisplayNameToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :twitch_username, :string
    add_column :venues, :display_name, :string
  end
end
