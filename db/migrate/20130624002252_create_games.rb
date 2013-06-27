class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.text :inspiration
      t.integer :event_id
      t.integer :venue_id
      t.integer :group_id

      t.timestamps
    end
  end
end
