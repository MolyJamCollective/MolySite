class CreditsController < ApplicationController

  def create
    @game = Game.find(params[:game_id])
    return redirect_to games_path, alert: 'Game not found' if @game.nil?

    @credit = Credit.new(params[:credit])
    @credit.game = @game

    respond_to do |format|
      if @credit.save
        format.html { redirect_to @credit, notice: 'Credit was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @game = Game.find(params[:game_id])
    return redirect_to games_path, alert: 'Game not found' if @game.nil?

    @credit = Credit.find(params[:id])

    respond_to do |format|
      if @credit.update_attributes(params[:credit])
        format.html { redirect_to @credit, notice: 'Credit was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    return redirect_to games_path, alert: 'Game not found' if @game.nil?
    
    @credit = Credit.find(params[:id])
    @credit.destroy

    respond_to do |format|
      format.html { redirect_to credits_url }
    end
  end
end
