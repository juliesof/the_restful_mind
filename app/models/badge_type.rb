class BadgeType < ActiveRecord::Base
  has_many :earned_badges
  has_many :users, through: :earned_badges

end
