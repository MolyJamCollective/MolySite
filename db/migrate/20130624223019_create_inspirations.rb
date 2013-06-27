class CreateInspirations < ActiveRecord::Migration
  def change
    create_table :inspirations do |t|
      t.text :quote
      t.string :source

      t.timestamps
    end
  end
end
