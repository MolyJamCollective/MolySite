class MailForwarder < ActionMailer::Base

  def receive(email)
    puts email

    #mail(subject: )
  end
end