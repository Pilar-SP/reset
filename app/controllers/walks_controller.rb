class WalksController < ApplicationController

  def new
    @walk = Walk.new
    @greenspace = Greenspace.find(params[:greenspace_id])
  end

  def create
    @walk = Walk.new(walk_params)
    @greenspace = Greenspace.find(params[:greenspace_id])
    @walk.greenspace = @greenspace
    @walk.starting_location = params[:query]
    @walk.user = current_user
    @walk.starting_location = $postcode
    if @walk.save
      redirect_to greenspace_walk_path(@greenspace, @walk)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @walk = Walk.find(params[:id])
    @markers = [
      {
        lat: @walk.greenspace.latitude,
        lng: @walk.greenspace.longitude
      },
      {
        lat: @walk.latitude,
        lng: @walk.longitude
      }

    ]
  end

  def edit
    @walk = Walk.find(params[:id])
  end

  private

  def walk_params
    params.require(:walk).permit(:notes, :stress_level_before, :stress_level_after, :starting_location, :music)
  end

end
