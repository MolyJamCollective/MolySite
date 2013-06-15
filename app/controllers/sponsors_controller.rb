class SponsorsController < ApplicationController
  load_and_authorize_resource :venue
  load_and_authorize_resource :sponsor, :through => :venue

  def new
    @venue = Venue.find(params[:venue_id])

    @sponsor = nil

    ##
    # Use a temporary sponsor if one exists, if not, create one.  This will
    # make it easier for sponsors to add attachments
    #
    @venue.sponsors.each do |s|
      if(s.temporary?)
        @sponsor = s
        break;
      end
    end

    if(@sponsor.nil?)
      @sponsor = @venue.sponsors.new
      @sponsor.save!()
    end

    redirect_to edit_venue_sponsor_path(@venue.id, @sponsor.id)
  end

  def edit
    @venue = Venue.find(params[:venue_id])
    @sponsor = @venue.sponsors.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def create
    @venue = Venue.find(params[:venue_id])
    @sponsor = @venue.sponsors.new(params[:sponsor])

    respond_to do |format|
      if @sponsor.save
        format.html { redirect_to @venue, notice: 'Sponsor was successfully added.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @venue = Venue.find(params[:venue_id])
    @sponsor = @venue.sponsors.find(params[:id])

    respond_to do |format|
      if @sponsor.update_attributes(params[:sponsor])
        format.html { redirect_to @venue, notice: 'Sponsor was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @venue = Venue.find(params[:venue_id])
    @sponsor = @venue.sponsors.find(params[:id])
    @sponsor.destroy

    respond_to do |format|
      format.html { redirect_to @venue }
    end
  end

  def move_up
    @venue = Venue.find(params[:venue_id])
    @sponsor = @venue.sponsors.find(params[:sponsor_id])
    @sponsor.move_up

    respond_to do |format|
        format.html { redirect_to @venue, notice: 'Sponsor was successfully updated.' }
    end
  end

  def move_down
    @venue = Venue.find(params[:venue_id])
    @sponsor = @venue.sponsors.find(params[:sponsor_id])
    @sponsor.move_down

    respond_to do |format|
        format.html { redirect_to @venue, notice: 'Sponsor was successfully updated.' }
    end
  end

end
