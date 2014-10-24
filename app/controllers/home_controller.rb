class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to new_earned_badge_path
    end
  end
end
