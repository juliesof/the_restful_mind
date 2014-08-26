class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :text
      t.belongs_to :quote_list

      t.timestamps
    end
  end
end
