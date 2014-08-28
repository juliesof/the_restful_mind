class CorrectSpelling < ActiveRecord::Migration
  def change
    change_table :sittings do |t|
      t.remove :users_id
      t.integer :user_id, index: true
    end
  end
end
