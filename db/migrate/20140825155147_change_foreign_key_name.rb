class ChangeForeignKeyName < ActiveRecord::Migration
  def change
    remove_column :users, :quote_lists_id, :integer

    change_table :users do |t|
      t.belongs_to :quote_list, index: true
    end
  end
end
