class MailForwarderController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
  	if params[:mail]
  	  MailForwarder.receive(params[:mail])
  	end
  end

end