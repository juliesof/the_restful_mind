class SittingsController < ApplicationController

  def index

  end

  def show

  end

  def new
    @sitting = Sitting.new
  end

  def create
     @sitting = Sitting.new(sitting_params)

    respond_to do |format|
      if @sitting.save
        format.html { redirect_to @sitting, notice: 'Sitting was successfully created.' }
        format.json { render :show, status: :created, location: @sitting }
      else
        format.html { render :new }
        format.json { render json: @sitting.errors, status: :unprocessable_entity }
      end
    end
  end

  def sitting_params
    params.require(:sitting).permit(:start_meditation,
     :end_meditation, :rating_post_sitting, :note_post_sitting)
  end
end

