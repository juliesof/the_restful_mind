class AddSittingNotes < ActiveRecord::Migration
  def change
    create_table :sittings do |t|
      t.text :notes
      t.belongs_to :users, index: true
    end

    change_table :users do |t|
      t.remove :sitting_notes
    end
  end
end
