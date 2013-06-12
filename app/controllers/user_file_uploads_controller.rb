class UserFileUploadsController < ApplicationController
  load_and_authorize_resource

  def index
    @files = current_user.user_file_uploads
  end

end
