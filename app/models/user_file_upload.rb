class UserFileUpload < ActiveRecord::Base

  belongs_to :user

  attr_accessible :user_id, :file_size, :file_path

end
