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
    @game.traditional_file.success_action_status = "201"

    respond_to do |format|
      format.html
    end
  end

  def index
    if params[:event_id].nil?
      @games = Game.all.shuffle
    else
      @games = Game.where(event_id: params[:event_id]).shuffle
    end
    
    respond_to do |format|
      format.html
    end
  end

  def new
    @game = Game.new

    respond_to do |format|
      format.html
    end
  end

  def create
    return render action: "new", alert: 'Invalid game name!' if params[:game][:name].to_s.empty?
    @game = Game.new(params[:game])
  
    respond_to do |format|
      if @game.save
        Credit.create!(user_id: current_user.id, game_id: @game.id)
        @game.add_user(current_user, :founder)
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
      else
        format.html { render action: "new", alert: 'Something broke!' }
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
    @game.traditional_file.key = params[:key] if params[:key] =~ /traditional_file/

    @game.save

    redirect_to @game, notice: 'file was successfully updated.'
  end

  def remove_file
    @game = Game.find(params[:game_id])

    @game.remove_windows_file! if params[:game][:file] == "windows_file"
    @game.remove_mac_file! if params[:game][:file] == "mac_file"
    @game.remove_linux_file! if params[:game][:file] == "linux_file"
    @game.remove_traditional_file! if params[:game][:file] == "traditional_file"

    @game.save

    redirect_to @game, notice: 'file was successfully removed.'
  end

end
