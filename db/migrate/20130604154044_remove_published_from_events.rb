class RemovePublishedFromEvents < ActiveRecord::Migration
  def up
  	remove_column :events, :published
  end

  def down
  	 add_column :events, :published, :boolean
  end
end
