class PagesController < ApplicationController

  def about
    authorize! :about, :page

    respond_to do |format|
      format.html
    end 
  end

  def dashboard
    authorize! :dashboard, :page

    respond_to do |format|
      format.html
    end 
  end
end
