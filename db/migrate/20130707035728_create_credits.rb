class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :game_id
      t.integer :user_id
      t.string :title

      t.timestamps
    end
  end
end
