class Attachment < ActiveRecord::Base

  belongs_to :attachable, :polymorphic => true
  belongs_to :user_file_upload  #reverse relationship since attachment holds fk

  attr_accessible :attachment_type, :attachable_id, :attachable_type, :remote_path

  validate :validate_path_set

  def file_path
    return remote_path || user_file_upload.file_path
  end

  ###
  # Either the remote_path or a user file upload must be attached
  ##
  def validate_path_set
    if remote_path.blank? and user_file_upload_id.blank?
     #one at least must be filled in
     return false
    elsif !remote_path.blank? and !user_file_upload_id.blank?
     #both can't be filled in
     return false
    else
     return true
    end
  end

end
