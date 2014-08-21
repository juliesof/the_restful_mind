class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :quote_text
      t.references :quote_list

      t.timestamps
    end
  end
end
