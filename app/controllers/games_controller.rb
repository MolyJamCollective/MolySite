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
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
      else
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
end
