class GamesController < ApplicationController
  load_and_authorize_resource

  def index
    @games = Game.all.shuffle

    respond_to do |format|
      format.html
    end
  end

  def show
    @game = Game.find(params[:id])

    @game.windows_file.success_action_status = "201"
    @game.mac_file.success_action_status = "201"
    @game.linux_file.success_action_status = "201"

    respond_to do |format|
      format.html
    end
  end

  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        Membership.set(current_user, @game.group_id, :founder)
        Membership.set(current_user, Group.where(name: "Jammers").first)
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
      else
        format.html { redirect_to @game, error: 'Something broke!' }
      end
    end
  end

  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.json { head :ok }
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
      else
        format.json { render json: @game.errors.full_messages, status: :uprocessable_entity}
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
    end
  end

  def upload_file
    @game = Game.find(params[:game_id])

    @game.windows_file.key = params[:key] if params[:key] =~ /windows_file/
    @game.mac_file.key = params[:key] if params[:key] =~ /mac_file/
    @game.linux_file.key = params[:key] if params[:key] =~ /linux_file/

    @game.save

    redirect_to @game, notice: 'file was successfully updated.'
  end
end
