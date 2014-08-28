class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :assign_quote, :access_earned_badges

  def after_sign_in_path_for(resource)
    current_user
  end

  private

  def assign_quote
    if user_signed_in?
      @random_quote = current_user.quote_list.random_quote
    end
  end

  def access_earned_badges
    if user_signed_in?
      @earned_badges = EarnedBadge.where(user_id: current_user.id)
    end
  end
end
