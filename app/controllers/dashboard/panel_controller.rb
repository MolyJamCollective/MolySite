class Dashboard::PanelController < ApplicationController
  def index
  	@users = User.find(:all)
  	@groups = Group.find(:all)
  end
end
