class GroupsController < ApplicationController
  load_and_authorize_resource

  def show
    @group = Group.find(params[:id])
    @memberships = Membership.where(group_id: @group.id)
  end

  def edit
    @group = Group.find(params[:id])
    @memberships = Membership.where(group_id: @group.id)
  end

  def update
    @group = Group.find(params[:id])
    if(@group.update_attributes(params[:group]))
      redirect_to :action => 'show', :id => @group
  	else
      @memberships = Membership.where(group_id: @group.id)
      render :action => 'edit'
    end
  end
end
