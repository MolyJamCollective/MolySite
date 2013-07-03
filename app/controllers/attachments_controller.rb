class AttachmentsController < ApplicationController
  load_and_authorize_resource

  layout false

  def new
    attachment_info = {
      :attachment_type => params[:type_cd],
      :attachable_id => params[:at_id],
      :attachable_type => params[:at_type]
    }
    @attachment = Attachment.new(attachment_info)
    @after_upload_path = user_file_uploads_upload_url(:attachment => attachment_info)

    @files = current_user.user_file_uploads
  end

  def reload
    attachment = Attachment.find(params[:id])
    @attachable = attachment.attachable
    @attachment_type = attachment.attachment_type
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
