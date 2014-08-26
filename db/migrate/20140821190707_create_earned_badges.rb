class CreateEarnedBadges < ActiveRecord::Migration
  def change
    create_table :badge_types do |t|
      t.string :day
      t.string :week
      t.string :month
      t.string :quarter
      t.string :year

      t.timestamps
    end

    create_table :earned_badges do |t|
      t.belongs_to :users
      t.belongs_to :badge_types

      t.timestamps
    end
  end
end
