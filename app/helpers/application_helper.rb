module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def attachment_thumbnail(attachment)
    #TODO logic for other media, assuming images for now
    if(attachment.is_an_image?)
      return "<img src=\"#{attachment.file_path}\" />"
    else
      return "<a href=\"#{attachment.file_path}\">#{attachment.file_name}</a>"
    end
  end

  def attachment_link(source_model, attachment_type, options = {}, link_text = "Add Attachment")
    options = {
      :max_attachments => 10,
      :show_wrapper => true
    }.merge(options)

    buffer = []

    attachmentsContainerId = "attachments_#{source_model.id}_#{source_model.class}_#{attachment_type}"

    if(options[:show_wrapper] == true)
      buffer.push('<div id="')
      buffer.push(attachmentsContainerId)
      buffer.push('" class="attachments">')
    end
    buffer.push('<div class="thumbs">')
    existing_attachments = source_model.attachments.where(:attachment_type => attachment_type)
    if(existing_attachments.count > 0)
      # render existing attachments

      existing_attachments.each do |a|
        buffer.push('<div class="attachment">')
        buffer.push(attachment_thumbnail(a))
        buffer.push('<a href="javascript: removeAttachment(')
        buffer.push(a.id)
        buffer.push(', \'')
        buffer.push(attachmentsContainerId)
        buffer.push('\');">Remove</a>')
        buffer.push('</div>')
      end
    end

    # TODO use javascript to do this in a sexier way than a popup
    # Link to attachments popup
    buffer.push("</div>")

    if(existing_attachments.count < options[:max_attachments])
      buffer.push(link_to link_text, new_attachment_path(:at_id => source_model.id, :at_type => source_model.class.to_s, :type_cd => attachment_type), :class => "attachment_link", :onclick => "return false;")
    end

    if(options[:show_wrapper] == true)
      buffer.push('</div>')
    end

    return raw buffer.join('')
  end

  def sponsor_tag(sponsor)
    buffer = []

    if(sponsor.url.blank? == false)
      buffer.push('<a href="')
      buffer.push(sponsor.url)
      if(sponsor.name.blank? == false)
        buffer.push('" ')
        buffer.push('alt="')
        buffer.push(sponsor.name)
      end
      buffer.push('">')
    end

    if(sponsor.has_logo?)
      buffer.push('<img width="100%" ')
      buffer.push('src="')
      buffer.push(sponsor.image_path)
      buffer.push('" />')
    else
      if(sponsor.name.blank? == false)
        buffer.push(sponsor.name)
      else
        buffer.push(sponsor.url)
      end
    end

    if(sponsor.url.blank? == false)
      buffer.push("</a>")
    end

    return raw buffer.join('')
  end
end
