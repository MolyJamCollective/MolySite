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
    @screenshot.game_id = @game.id

    respond_to do |format|
      if @screenshot.save
        format.html { redirect_to @screenshot.game, notice: 'Screenshot was successfully created.' }
        format.json { render json: @screenshot.game, status: :created, location: @screenshot }
      else
        format.html { render action: "new" }
        format.json { render json: @screenshot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @game = Game.find(params[:game_id])
    @screenshot = Screenshot.find(params[:id])

    respond_to do |format|
      if @screenshot.update_attributes(params[:screenshot])
        format.html { redirect_to @screenshot.game, notice: 'Screenshot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @screenshot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    @screenshot = Screenshot.find(params[:id])
    @screenshot.destroy

    respond_to do |format|
      format.html { redirect_to @game }
      format.json { head :no_content }
    end
  end
end
