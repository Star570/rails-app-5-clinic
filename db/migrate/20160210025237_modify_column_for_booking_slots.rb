class ModifyColumnForBookingSlots < ActiveRecord::Migration
  def change
    add_column :booking_slots, :booking_date, :date
    remove_column :booking_slots, :count
  end
end
