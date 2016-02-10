class RemoveSendPinCountToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :send_pin_count
  end
end
