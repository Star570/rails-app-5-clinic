class AddDateToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :reserve_date, :date
  end
end
