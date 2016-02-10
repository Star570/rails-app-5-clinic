class AddPinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pin, :string
    add_column :users, :pin_enter_error_count, :integer, default: 0    
    add_column :users, :forget_count, :integer, default: 0
  end
end
