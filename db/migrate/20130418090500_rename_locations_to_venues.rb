class RenameLocationsToVenues < ActiveRecord::Migration
  def up
  	rename_table :locations, :venues
  end

  def down
  	rename_table :venues, :locations
  end
end
