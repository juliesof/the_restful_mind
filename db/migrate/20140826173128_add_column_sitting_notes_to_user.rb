class AddColumnSittingNotesToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.text :sitting_notes
    end
  end
end
