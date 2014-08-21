class SittingsController < ApplicationController

  respond_to :html, :json

  def index
    @sittings = Sitting.all
  end

  def show

  end

  def new
    @sitting = Sitting.new
  end

  def create
    @sitting = Sitting.new(sitting_params)

    @sitting.save
    respond_with @sitting
  end

  private
  def sitting_params
    params.require(:sitting).permit(:start_meditation,
     :end_meditation, :rating_post_sitting, :note_post_sitting)
  end
end

