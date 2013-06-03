class RemoveContactAndAddressFromVenues < ActiveRecord::Migration
  def up
    remove_column :venues, :contact
    remove_column :venues, :address
  end

  def down
  	add_column :venues, :contact, :string
  	add_column :venues, :address, :string
  end
end
