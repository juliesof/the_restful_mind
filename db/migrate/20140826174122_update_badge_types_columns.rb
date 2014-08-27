class UpdateBadgeTypesColumns < ActiveRecord::Migration
  def change
    change_table :badge_types do |t|
      t.remove :day
      t.remove :week
      t.remove :month
      t.remove :quarter
      t.remove :year

      t.string :name
      t.string :img_url
    end
  end
end
