class AddGroupIdToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :group_id, :integer
  end
end
