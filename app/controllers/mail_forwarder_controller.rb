class MailForwarderController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_authorization_check

  def create
    message = Mail.new(params[:message])
    if(MailForwarder.receive(message))
  	  render nothing: true, status: 204
  	else
      render nothing: true, status: 400
  	end
  end

end