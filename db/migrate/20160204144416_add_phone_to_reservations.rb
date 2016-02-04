class AddPhoneToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :phone, :integer
  end
end
