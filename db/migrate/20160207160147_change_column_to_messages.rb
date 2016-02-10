class ChangeColumnToMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :name
    add_column :messages, :anonymous, :boolean
  end
end
