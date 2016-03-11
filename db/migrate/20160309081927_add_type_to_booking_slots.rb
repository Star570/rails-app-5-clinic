class AddTypeToBookingSlots < ActiveRecord::Migration
  def change
    add_column :booking_slots, :booking_type, :integer, default: 0       
  end
end
