class MailForwarder < ActionMailer::Base

  def receive(mail)
  	mail_to = nil
    if(mail.to.downcase == "webmasters@molyjam.com")
     
      mail_to = Array.new
      Group.where(name: "Webmasters").first.users.each{ |user| mail_to.push(user.email)}

    elsif(mail.to.downcase == "organizers@molyjam.com")

      mail_to = Array.new
      Group.where(name: "Organizers").first.users.each{ |user| mail_to.push(user.email)}

    else

      target_venue = nil
      Venue.all.each{ |venue| break target_venue = venue if mail.to.downcase == venue.email.downcase }
      return false if target_venue.nil?
      
      mail_to = Array.new
      target_venue.hosts.each{ |user| mail_to.push(user.email) }
    end

    return false if mail_to.empty?

    mail(subject: mail.subject, to: mail_to, from: mail.from, ) do |format|
      format.text {render text: mail.body}
    end
  end

end