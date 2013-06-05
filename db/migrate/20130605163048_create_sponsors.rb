class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.integer :venue_id
      t.integer :rank
      t.string :url
      t.timestamps
    end

    add_attachment :sponsors, :image
  end
end
