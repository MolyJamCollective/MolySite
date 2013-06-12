class CreateUserFileUploads < ActiveRecord::Migration
  def change
    create_table :user_file_uploads do |t|
      t.integer :user_id
      t.integer :file_size
      t.string :file_bucket
      t.string :file_path

      t.timestamps
    end
  end
end
