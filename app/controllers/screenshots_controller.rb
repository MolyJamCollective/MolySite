class ScreenshotsController < ApplicationController
  load_and_authorize_resource :game
  load_and_authorize_resource :screenshot, :through => :game

  def show
    @game = Game.find(params[:game_id])
    @screenshot = Screenshot.find(params[:id])

    redirect_to @screenshot.image_url
  end

  def create
    @game = Game.find(params[:game_id])
    @screenshot = Screenshot.new(params[:screenshot])
    @screenshot.game_id = params[:game_id];
    @screenshot.save
  end

  def destroy
    @game = Game.find(params[:game_id])
    @screenshot = Screenshot.find(params[:id])
    @screenshot.destroy

    respond_to do |format|
      format.html { redirect_to @game }
    end
  end
end
