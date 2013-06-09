class MembershipsController < ApplicationController
  load_and_authorize_resource  

  def create
  	@membership = Membership.new(params[:membership])

    respond_to do |format|
      if @membership.save
        format.html { redirect_to :back, notice: "#{@membership.user.name} was added to #{@membership.group.name}" }
      else
        format.html { redirect_to :back, alert: "#{@membership.user.name} was not added to #{@membership.group.name}" }
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