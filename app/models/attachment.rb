class Attachment < ActiveRecord::Base

  belongs_to :attachable, :polymorphic => true
  belongs_to :user_file_upload  #reverse relationship since attachment holds fk

  attr_accessible :attachment_type, :attachable_id, :attachable_type, :remote_path

  validate :validate_path_set

  def is_an_image?
    if(user_file_upload.present?)
      return user_file_upload.is_an_image?()
    else
      #TODO stole this from user_file_uploads, there's a better home for both of these methods
      extension = file_path.split(".").last.downcase
      if(extension == "jpg" || extension == "png" || extension == "gif" || extension == "tga")
        return true
      end
    end

    return false
  end

  def file_path
    return remote_path || user_file_upload.file_path
  end

  def file_name
    return file_path.split('/').last
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
