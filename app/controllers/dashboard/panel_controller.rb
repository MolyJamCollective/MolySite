class Dashboard::PanelController < ApplicationController
  skip_authorization_check
  
  def index
    @users = User.find(:all)
    @groups = Group.find(:all)
    @events = Event.find(:all)
  end
end
