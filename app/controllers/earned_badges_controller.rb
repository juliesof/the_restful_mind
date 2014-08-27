class EarnedBadgesController < ApplicationController

  def new
    @day_badge = EarnedBadge.new
  end

  def create
    @day_badge = EarnedBadge.new
    @day_badge.user = current_user
    @day_badge.badge_type = BadgeType.find_by(name: 'day')
    @day_badge.save

    redirect_to root_path
  end
end
