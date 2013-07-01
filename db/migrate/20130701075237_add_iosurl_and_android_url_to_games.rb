class AddIosurlAndAndroidUrlToGames < ActiveRecord::Migration
  def change
  	add_column :games, :android_url, :string
  	add_column :games, :ios_url, :string
  end
end
