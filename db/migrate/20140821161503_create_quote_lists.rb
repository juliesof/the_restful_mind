class CreateQuoteLists < ActiveRecord::Migration
  def change
    create_table :quote_lists do |t|
      t.string :list_name
      t.text :quote_01
      t.text :quote_02
      t.text :quote_03
      t.text :quote_04
      t.text :quote_05
      t.text :quote_06
      t.text :quote_07
      t.text :quote_08
      t.text :quote_09
      t.text :quote_10
      t.references :user, index: true

      t.timestamps
    end
  end
end
