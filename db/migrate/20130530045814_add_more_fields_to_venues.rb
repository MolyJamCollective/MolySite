class AddMoreFieldsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :region, :string
    add_column :venues, :country, :string
    add_column :venues, :city, :string
    add_column :venues, :contact, :string
  end
end
