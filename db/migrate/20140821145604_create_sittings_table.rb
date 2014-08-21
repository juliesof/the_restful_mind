class CreateSittingsTable < ActiveRecord::Migration
  def change
    create_table :sittings do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :user, index: true

      t.timestamps
    end
  end
end
