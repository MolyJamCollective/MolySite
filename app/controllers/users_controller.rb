class UsersController < ApplicationController
  load_and_authorize_resource  

  def index
    user = User.search(params[:search])

    return redirect_to user_path(user) unless user.nil?
    return redirect_to :back, :alert => "User not found!"
  rescue ActionController::RedirectBackError
    redirect_to '/'
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def update
    @user = User.find(params[:id])
    # TODO:: Prevent user from changing username/password/email

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
