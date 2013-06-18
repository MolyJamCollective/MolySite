class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      #polymorphic fields
      t.integer :attachable_id
      t.string :attachable_type

      t.string :attachment_type, :null => false

      #Either by remote path, or by S3 upload
      t.string :remote_path
      t.integer :user_file_upload_id

      t.timestamps
    end
  end
end
