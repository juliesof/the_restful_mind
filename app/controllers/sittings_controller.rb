class SittingsController < ApplicationController
  def new
    @sitting_note = Sitting.new
  end

  def create
    @sitting_note = Sitting.new(sittings_params)
    @sitting_note.user = current_user
    @sitting_note.save

    redirect_to current_user
  end

  private

  def sittings_params
    params.require(:sitting).permit(:notes)
  end
end
