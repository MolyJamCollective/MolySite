class AddStreetAndStateToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :street, :string
    add_column :venues, :state, :string
  end
end
