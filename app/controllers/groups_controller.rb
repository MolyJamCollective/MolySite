class GroupsController < ApplicationController
  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
    @memberships = Membership.find(group)
    @members = User.find(memberships)
  end

  def update
    @group = Group.find(params[:id])
    if(@group.update_attributes(params[:group]))
      redirect_to :action => 'show', :id => @group
  	else
      @memberships = Membership.find(group)
      @members = User.find(memberships)
      render :action => 'edit'
    end
  end
end
