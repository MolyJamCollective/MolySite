class MembershipsController < ApplicationController
  load_and_authorize_resource  

  def create
  	@membership = Membership.new(params[:membership])

    if(@membership.user_id.nil? && !params[:user].nil?)
      user = User.where(username: params[:user][:username]).first unless params[:user][:username].nil?
      @membership.user_id = user.id unless user.nil?
    end

    respond_to do |format|
      if !@membership.user_id.nil? && @membership.save
        format.html { redirect_to :back, notice: "#{@membership.user.name} was added to #{@membership.group.name}" }
      else
        format.html { redirect_to :back, alert: "User was not added to group" }
      end
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    notice = "#{@membership.user.name} was removed from #{@membership.group.name}"
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: notice }
    end
  end
end