class UserFileUploadsController < ApplicationController
  load_and_authorize_resource

  def index
    @files = current_user.user_file_uploads

    @user_file_upload = UserFileUpload.new
    @uploader = @user_file_upload.file_path
    @uploader.success_action_redirect = user_file_uploads_upload_url
  end

  def upload

puts params.inspect

    ##
    # Uploads when using Amazon S3 will give you params simliar to this:
    #
    # {"bucket"=>"molyjam", "key"=>"uploads/0fafae56-d67a-4b99-8297-41d8231fb943/filename.png", "etag"=>"\"74d28ef9b9109dc4c45bf2b272ba1ab6\"", "controller"=>"user_file_uploads", "action"=>"upload"}
    ##

    log = UserFileUpload.new()

    log.user_id = current_user.id
    log.file_bucket = params[:bucket]

    puts "* #{params[:key]}"
    puts "*#{log.file_path.inspect}*"
    puts "8#{log.file_path.direct_fog_url(:with_path => true)}7"

    log.remote_file_path_url = log.file_path.direct_fog_url(:with_path => true)

    puts "9#{log.remote_file_path_url}9"

    log.file_size = 20 #todo find a way to get thie uploaded file size
    log.save!

    puts log.inspect

    redirect_to(user_file_uploads_url)
  end

end

