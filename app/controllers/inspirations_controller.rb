class InspirationsController < ApplicationController
  load_and_authorize_resource
 
  def index
    if(params[:show] == "all")
      @inspirations = Inspiration.all
      @mode = :all
    else
      @inspirations = Inspiration.find(:all, :order => "id desc", :limit => 22)
      @mode = :some
    end

    logger.info "#{params[:action]}"

    respond_to do |format|
      format.html { render layout: "inspiration" }
    end
  end

  def show
    @inspiration = Inspiration.find(params[:id])

    respond_to do |format|
      format.html { render layout: "inspiration" }
    end
  end

  def new
    @inspiration = Inspiration.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @inspiration = Inspiration.find(params[:id])
  end

  def create
    @inspiration = Inspiration.new(params[:inspiration])

    respond_to do |format|
      if @inspiration.save
        format.html { redirect_to @inspiration, notice: 'Inspiration was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @inspiration = Inspiration.find(params[:id])

    respond_to do |format|
      if @inspiration.update_attributes(params[:inspiration])
        format.html { redirect_to @inspiration, notice: 'Inspiration was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @inspiration = Inspiration.find(params[:id])
    @inspiration.destroy

    respond_to do |format|
      format.html { redirect_to inspirations_url }
    end
  end
end
