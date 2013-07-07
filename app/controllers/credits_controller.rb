class CreditsController < ApplicationController
  load_and_authorize_resource :game
  load_and_authorize_resource :credit, :through => :game

  def create
    @game = Game.find(params[:game_id])
    return redirect_to games_path, alert: 'Game not found' if @game.nil?

    return redirect_to @game, alert: 'Invalid Name' if params[:user][:name].to_s.empty?
    return redirect_to @game, alert: 'Invalid Email' if params[:user][:email].to_s.empty?

    @credit = Credit.new(params[:credit])
    @credit.game = @game

    @credit.find_or_invite_user params[:user][:email], params[:user][:name]

    return redirect_to @game, alert: 'Credit already exist' unless Credit.where(game_id: @credit.game_id, user_id: @credit.user_id).empty?

    respond_to do |format|
      if @credit.save
        @game.add_user(@credit.user, :officer)
        format.html { redirect_to @game, notice: 'Credit was successfully created.' }
      else
        format.html { redirect_to @game, alter: 'Credit was not created.' }
      end
    end
  end

  def update
    @game = Game.find(params[:game_id])
    @credit = Credit.find(params[:id])

    respond_to do |format|
      if @credit.update_attributes(params[:credit])
        format.json { head :ok }
        format.html { redirect_to @game, notice: 'Credit was successfully updated.' }
      else
        format.json { render json: @game.errors.full_messages, status: :uprocessable_entity}
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
      format.html { redirect_to @game, notice: 'Credit was successfully removed.' }
    end
  end
end
