class CreateBookingSlots < ActiveRecord::Migration
  def change
    create_table :booking_slots do |t|
      t.integer :time_slot
      t.boolean :bookable
      t.integer :count
      t.references :booking_date, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
