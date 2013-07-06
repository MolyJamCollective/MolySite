class AddDescriptionAndDirectionsToGames < ActiveRecord::Migration
  def change
    add_column :games, :description, :text
    add_column :games, :directions, :text
  end
end
