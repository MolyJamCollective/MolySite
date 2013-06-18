class EventsController < ApplicationController
  load_and_authorize_resource  

  def index
    @events = Event.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @event = Event.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
    end
  end
  
  def show_current
    @event = Event.last

    respond_to do |format|
      if(@event.nil?)
        format.html { redirect_to action: :index }
      else
        format.html { render action: "show" }
      end
    end
  end

end
