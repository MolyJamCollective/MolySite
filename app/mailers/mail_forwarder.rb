class MailForwarder < ActionMailer::Base

  def forward_email(mail)

    #TODO Handle Multiable Target
    mail_to = nil
    if(mail.to.first.downcase == "webmasters@molyjam.com")
     
      mail_to = Array.new
      Group.where(name: "Webmasters").first.users.each{ |user| mail_to.push(user.email)}

    elsif(mail.to.first.downcase == "organizers@molyjam.com")

      mail_to = Array.new
      Group.where(name: "Organizers").first.users.each{ |user| mail_to.push(user.email)}

    else

      target_venue = nil
      Venue.all.each{ |venue| break target_venue = venue if mail.to.first.downcase == venue.email.downcase }
      return false if target_venue.nil?
      
      mail_to = Array.new
      target_venue.hosts.each{ |user| mail_to.push(user.email) }
    end

    return false if mail_to.empty?

    mail(subject: mail.subject, to: mail_to, from: "reply.#{mail.to.first}", reply_to: mail.from) do |format|
      format.text { render text: mail.text_part.body.to_s } unless mail.text_part.nil?
      format.html { render text: mail.html_part.body.to_s } unless mail.html_part.nil?
    end

    return true
  end

end