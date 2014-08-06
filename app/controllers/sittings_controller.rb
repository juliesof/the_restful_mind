class SittingsController < ApplicationController

  def new
    @sitting = Sitting.new
  end

  def create

  end

  def sitting_params
    params.require(:sitting).permit(:start_meditation,
     :end_meditation, :rating_post_sitting, :note_post_sitting)
  end
end

