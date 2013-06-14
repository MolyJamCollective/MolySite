module ApplicationHelper

  def attachment_thumbnail(attachment)
    #TODO logic for other media, assuming images for now
    return "<img src=\"#{attachment.file_path}\" />"
  end

  def attachment_link(source_model, attachment_type)
    buffer = []

    can_add_more_attachments = true
    existing_attachments = source_model.attachments.where(:attachment_type => attachment_type)
    if(existing_attachments.count > 0)
      # render existing attachments

      existing_attachments.each do |a|
        buffer.push(attachment_thumbnail(a))
      end

      #TODO have logic for max attachments rather than just 1
      can_add_more_attachments = false
    end

    # TODO use javascript to do this in a sexier way than a popup
    # Link to attachments popup
    buffer.push(link_to "Add Attachment", new_attachment_path(:at_id => source_model.id, :at_type => source_model.class.to_s, :type_cd => attachment_type), :target => "_blank")

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
