class RemoveBookingDateIdToBookingSlots < ActiveRecord::Migration
  def change
    remove_column :booking_slots, :booking_date_id
  end
end
