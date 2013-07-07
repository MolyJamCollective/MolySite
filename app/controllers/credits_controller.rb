class CreditsController < ApplicationController

  def create
    @credit = Credit.new(params[:credit])

    respond_to do |format|
      if @credit.save
        format.html { redirect_to @credit, notice: 'Credit was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @credit = Credit.find(params[:id])

    respond_to do |format|
      if @credit.update_attributes(params[:credit])
        format.html { redirect_to @credit, notice: 'Credit was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @credit = Credit.find(params[:id])
    @credit.destroy

    respond_to do |format|
      format.html { redirect_to credits_url }
    end
  end
end
