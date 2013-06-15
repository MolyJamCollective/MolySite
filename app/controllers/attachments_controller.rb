class AttachmentsController < ApplicationController
  load_and_authorize_resource

  layout "minimal"

  def new
    @attachment = Attachment.new()
    session[:attachment_info] = {
      :attachment_type => params[:type_cd],
      :attachable_id => params[:at_id],
      :attachable_type => params[:at_type]
    }

    @user_file_upload = UserFileUpload.new
    @uploader = @user_file_upload.file_uploader
    @uploader.success_action_redirect = user_file_uploads_upload_url(:attach_redirect => true)

    @files = current_user.user_file_uploads
  end

  def create
    attachment_info_hash = {}
    if(params[:attachment])
      attachment_info_hash = attachment_info_hash.merge(params[:attachment])
    end

    # Grab attachment information from the session if we can, and clean it up
    # Doing this after the attachment param will also protect the ids
    if(session[:attachment_info])
      attachment_info_hash = attachment_info_hash.merge(session.delete(:attachment_info))
    end

    @attachment = Attachment.new(attachment_info_hash)

    uploaded_file_id = params[:file_id]
    if(uploaded_file_id)
      @attachment.user_file_upload_id = uploaded_file_id
    end


    @attachment.save!()
  end

end
