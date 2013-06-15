class UserFileUpload < ActiveRecord::Base

  belongs_to :user

  attr_accessible :user_id, :file_size, :file_path, :file_bucket

  mount_uploader :file_uploader, UserFileUploader

  def file_name
    if(file_path.nil?)
      return ""
    end
    return file_path.split("/").last
  end

  def is_an_image?
    return media_type.equals(:image)
  end

  def media_type
    #TODO it'll probably be a better idea to track mime-type, but we don't have it now
    if(file_path.blank? || file_path.match(/\./).nil?)
      return nil
    end

    extension = file_path.split(".").last.downcase

    if(extension == "jpg" || extension == "png" || extension == "gif" || extension == "tga")
      return :image
    else
      return :binary
    end
  end

end
