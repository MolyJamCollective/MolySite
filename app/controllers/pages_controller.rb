class PagesController < ApplicationController

  def about
    authorize! :about, :page

    respond_to do |format|
      format.html
    end 
  end

  def dashboard
    authorize! :dashboard, :page

    @users_last5 = User.find(:all, order: "id DESC", limit: 5)

    respond_to do |format|
      format.html
    end 
  end
end
