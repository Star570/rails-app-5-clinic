class RemoveColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :forget_count
    rename_column :users, :pin_enter_error_count, :send_pin_count    
  end
end
