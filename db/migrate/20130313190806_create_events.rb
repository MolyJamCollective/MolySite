class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null:false, unique:true
      t.text :description
      t.datetime :start_date, null:false
      t.datetime :end_date, null:false
      t.boolean :published, default:false

      t.timestamps
    end
  end
end
