class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.integer :event_id
      t.integer :order
      t.string :url
      t.timestamps
    end

    add_attachment :sponsors, :image
  end
end
