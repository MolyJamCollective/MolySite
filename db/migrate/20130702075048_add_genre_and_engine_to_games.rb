class AddGenreAndEngineToGames < ActiveRecord::Migration
  def change
    add_column :games, :genre, :string
    add_column :games, :engine, :string
  end
end
