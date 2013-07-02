module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def attachment_thumbnail(attachment)
    #TODO logic for other media, assuming images for now
    return "<img src=\"#{attachment.file_path}\" />"
  end

  def attachment_link(source_model, attachment_type, options = {})
    options = {
      :max_attachments => 3,
      :show_wraper => true
    }.merge(options)

    buffer = []

    if(options[:show_wraper] == true)
      buffer.push('<div id="attachments_')
      buffer.push(source_model.id)
      buffer.push("_")
      buffer.push(source_model.class)
      buffer.push("_")
      buffer.push(attachment_type)
      buffer.push('">')
    end
    buffer.push('<div class="thumbs">')
    existing_attachments = source_model.attachments.where(:attachment_type => attachment_type)
    if(existing_attachments.count > 0)
      # render existing attachments

      existing_attachments.each do |a|
        buffer.push(attachment_thumbnail(a))
      end
    end

    # TODO use javascript to do this in a sexier way than a popup
    # Link to attachments popup
    buffer.push("</div>")

    if(existing_attachments.count < options[:max_attachments])
      buffer.push(link_to "Add Attachment", new_attachment_path(:at_id => source_model.id, :at_type => source_model.class.to_s, :type_cd => attachment_type), :class => "attachment_link")
    end

    if(options[:show_wraper] == true)
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
