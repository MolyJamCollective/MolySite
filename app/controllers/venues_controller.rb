class VenuesController < ApplicationController
  load_and_authorize_resource

  def index
    @venues = Venue.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @venue = Venue.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @venue = Venue.new
    @events = Event.all

    respond_to do |format|
      format.html
    end
  end

  def edit
    @venue = Venue.find(params[:id])
    @events = Event.all
  end

  def create
    @venue = Venue.new(params[:venue])
    @events = Event.all

    respond_to do |format|
      if @venue.save
        format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
        @venue.register_user(current_user, true) if user_signed_in?
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @venue = Venue.find(params[:id])
    @events = Event.all

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to venues_url }
    end
  end

  def approve
    @venue = Venue.find(params[:venue_id])
    @venue.approved = true;
    @venue.save

    respond_to do |format|
      format.html { render action: "show" }
    end
  end
end
