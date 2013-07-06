class AddPlayInBrowserUrlAndPlayInBrowserTypeToGames < ActiveRecord::Migration
  def change
  	add_column :games, :play_in_browser_url, :string
  	add_column :games, :play_in_browser_type, :string
  end
end
