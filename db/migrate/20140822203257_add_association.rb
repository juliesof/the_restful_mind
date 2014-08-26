class AddAssociation < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.belongs_to :quote_lists, index: true
    end
  end
end
