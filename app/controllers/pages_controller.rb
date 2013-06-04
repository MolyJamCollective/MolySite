class PagesController < ApplicationController
  skip_authorization_check

  def about
    respond_to do |format|
      format.html
    end 
  end
end
