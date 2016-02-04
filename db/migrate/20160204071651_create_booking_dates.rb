class CreateBookingDates < ActiveRecord::Migration
  def change
    create_table :booking_dates do |t|
      t.date :b_date
      t.boolean :bookable

      t.timestamps null: false
    end
  end
end
