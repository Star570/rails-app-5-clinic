class CreateBookingSlots < ActiveRecord::Migration
  def change
    create_table :booking_slots do |t|
      t.integer :time_slot
      t.boolean :bookable
      t.integer :count

      t.timestamps null: false
    end
  end
end
