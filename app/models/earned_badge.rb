class EarnedBadge < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge_type

end
