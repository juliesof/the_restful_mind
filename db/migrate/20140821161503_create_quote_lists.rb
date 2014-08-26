class CreateQuoteLists < ActiveRecord::Migration
  def change
    create_table :quote_lists do |t|
      t.string :list_name

      t.timestamps
    end
  end
end
