class UserFileUploadsController < ApplicationController
  load_and_authorize_resource


  def index
    @files = current_user.user_file_uploads
    @after_upload_path = user_file_uploads_upload_url
  end

  def upload
    ##
    # Uploads when using Amazon S3 will give you params simliar to this:
    #
    # {"bucket"=>"molyjam", "key"=>"uploads/0fafae56-d67a-4b99-8297-41d8231fb943/filename.png", "etag"=>"\"74d28ef9b9109dc4c45bf2b272ba1ab6\"", "controller"=>"user_file_uploads", "action"=>"upload"}
    ##

    log = UserFileUpload.new()

    log.user_id = current_user.id
    #log.file_bucket = params[:bucket]

    log.file_size = params[:file_size]
    log.file_path = params[:full_path]
    log.save!

    if(params[:attach_redirect].present?)
     # redirect_to(new_attachment_url(:file_id => log.id))
    else
      #redirect_to(user_file_uploads_url)
    end

    respond_to do |format|
      format.json {render json: log}
    end

  end

end

