class AddWindowsFileAndMacFileAndLinuxFileToGames < ActiveRecord::Migration
  def change
    add_column :games, :windows_file, :string
    add_column :games, :mac_file, :string
    add_column :games, :linux_file, :string
  end
end
