class MailForwarderController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_authorize_resource

  def create
  	if params[:mail]
  	  MailForwarder.receive(params[:mail])
  	end
  end

end