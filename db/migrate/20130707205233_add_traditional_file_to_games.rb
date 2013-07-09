class AddTraditionalFileToGames < ActiveRecord::Migration
  def change
    add_column :games, :traditional_file, :string
  end
end
