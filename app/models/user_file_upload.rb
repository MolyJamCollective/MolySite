class UserFileUpload < ActiveRecord::Base

  belongs_to :user

  attr_accessible :user_id, :file_size, :file_path, :file_bucket

  mount_uploader :file_path, UserFileUploader

end
