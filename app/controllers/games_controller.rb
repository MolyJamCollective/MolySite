class GamesController < ApplicationController
  load_and_authorize_resource

  def index
    @games = Game.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @game = Game.find(params[:id])

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

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        Membership.set(current_user, @game.group_id, :founder)
        Membership.set(current_user, Group.where(name: "Jammers").first)
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
      else
        format.html { render action: "new" }
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

  def add_user
    @game = Game.find(params[:game_id])
    redirect_to @game, error: "Invalid username" if params[:user][:username].nil?

    user = User.where(username: params[:user][:username]).first
    redirect_to @game, error: "User not found." if user.nil?

    Membership.set(user.id, @game.group_id, :member)
    Membership.set(user.id, Group.where(name: "Jammers").first)

    redirect_to @game, notice: "#{user.username} was successfully added."
  end

  def remove_user
    @game = Game.find(params[:game_id])
    redirect_to @game, error: "Invalid user id" if params[:user][:id].nil?

    user = User.find(params[:user][:id])
    redirect_to @game, error: "User not found." if user.nil?

    Membership.where(user_id: user.id, group_id: @game.group_id).first.destroy
    Membership.where(user_id: user.id, group_id: Group.where(name: "Jammers").first).first.destroy

    redirect_to @game, notice: "User was successfully removed."
  end
end
