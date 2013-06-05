class SponsorsController < ApplicationController
  #load_and_authorize_resource
  skip_authorization_check

  def new
    @sponsor = Sponsor.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @sponsor = Sponsor.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def show
    @sponsor = Sponsor.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def create
    @sponsor = Sponsor.new(params[:sponsor])

    respond_to do |format|
      if @sponsor.save
        format.html { redirect_to @sponsor, notice: 'Sponsor was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @sponsor = Sponsor.find(params[:id])

    respond_to do |format|
      if @sponsor.update_attributes(params[:sponsor])
        format.html { redirect_to @sponsor, notice: 'Sponsor was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @sponsor = Sponsor.find(params[:id])
    @sponsor.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
    end
  end

end