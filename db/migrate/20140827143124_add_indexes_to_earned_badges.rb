class AddIndexesToEarnedBadges < ActiveRecord::Migration
  def change
    change_table :earned_badges do |t|
      t.remove :users_id
      t.integer :user_id, index: true

      t.remove :badge_types_id
      t.integer :badge_type_id, index: true
    end
  end
end
