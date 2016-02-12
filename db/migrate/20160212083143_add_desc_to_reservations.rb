class AddDescToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :desc, :string
  end
end
