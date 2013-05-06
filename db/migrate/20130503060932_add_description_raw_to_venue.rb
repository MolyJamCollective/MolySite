class AddDescriptionRawToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :description_raw, :text
  end
end
