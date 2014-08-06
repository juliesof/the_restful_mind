class CreateSittings < ActiveRecord::Migration
  def change
    create_table :sittings do |t|
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :rating_post_sitting
      t.text :note_post_sitting
    end
  end
end
