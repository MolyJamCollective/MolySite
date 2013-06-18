class PagesController < ApplicationController

  def about
    authorize! :about, :page

    respond_to do |format|
      format.html
    end 
  end

  def dashboard
    authorize! :dashboard, :page

    @users = User.find(:all, order: "id DESC")

    respond_to do |format|
      format.html
    end 
  end

  def news 
    authorize! :about, :page

    respond_to do |format|
      format.html
    end 
  end 
end
