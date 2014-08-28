class EarnedBadge < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge_type

  after_save :adjust

  def adjust
    if EarnedBadge.days(user.id).size >= 7
      EarnedBadge.create_week(user.id)
    end
    if EarnedBadge.weeks(user.id).size >= 3
      EarnedBadge.create_month(user.id)
    end
    if EarnedBadge.months(user.id).size >= 3
      EarnedBadge.create_quarter(user.id)
    end
    if EarnedBadge.quarters(user.id).size >= 2
      EarnedBadge.create_years(user.id)
    end
  end


#methods used within the adjust method

  #methods that return a badge type from database into a collection
  def self.days(user_id)
    BadgeType.find_by(name: 'day').earned_badges.where(user_id: user_id)
  end

  def self.weeks(user_id)
    BadgeType.find_by(name: 'week').earned_badges.where(user_id: user_id)
  end

  def self.months(user_id)
    BadgeType.find_by(name: 'month').earned_badges.where(user_id: user_id)
  end

  def self.quarters(user_id)
    BadgeType.find_by(name: 'quarter').earned_badges.where(user_id: user_id)
  end

  def self.years(user_id)
    BadgeType.find_by(name: 'year').earned_badges.where(user_id: user_id)
  end

  #methods to increment and destroy badges as necessary
  def self.create_week(user_id)
    week_badge = EarnedBadge.new
    week_badge.user_id = user_id
    week_badge.badge_type = BadgeType.find_by(name: 'week')
    self.days(user_id).destroy_all
    week_badge.save
  end

  def self.create_month(user_id)
    month_badge = EarnedBadge.new
    month_badge.user_id = user_id
    month_badge.badge_type = BadgeType.find_by(name: 'month')
    self.weeks(user_id).destroy_all
    month_badge.save
  end

  def self.create_quarter(user_id)
    quarter_badge = EarnedBadge.new
    quarter_badge.user_id = user_id
    quarter_badge.badge_type = BadgeType.find_by(name: 'quarter')
    self.months(user_id).destroy_all
    quarter_badge.save
  end

  def self.create_year(user_id)
    year_badge = EarnedBadge.new
    year_badge.user_id = user_id
    year_badge.badge_type = BadgeType.find_by(name: 'year')
    year_badge.save
  end
end


