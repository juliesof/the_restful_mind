class DropSittings < ActiveRecord::Migration
  def change
    drop_table :sittings
  end
end
