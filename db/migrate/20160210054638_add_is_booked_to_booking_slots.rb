class AddIsBookedToBookingSlots < ActiveRecord::Migration
  def change
    add_column :booking_slots, :is_booked, :boolean, default: false
  end
end
