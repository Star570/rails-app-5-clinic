class ModifyColumnForReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :reserve_date
  end
end
