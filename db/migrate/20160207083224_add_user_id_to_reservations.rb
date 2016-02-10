class AddUserIdToReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :name
    remove_column :reservations, :phone    
    add_column    :reservations, :user_id, :integer
    add_index     :reservations, :user_id           
  end
end
