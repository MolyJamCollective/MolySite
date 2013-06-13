class MailForwarderController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_authorization_check

  def create
  	if params[:mail]
  	  MailForwarder.receive(params[:mail])
  	end
  	render nothing: true
  end

end