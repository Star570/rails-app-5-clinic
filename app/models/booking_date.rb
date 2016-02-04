class BookingDate < ActiveRecord::Base
  has_many :booking_slots, dependent: :destroy

  def self.update_latest_booking

    if BookingDate.all.empty?
      BookingDate.create(:b_date => Date.today,
                         :bookable => true)
      latest_booking =  BookingDate.order("b_date DESC").first
      BookingSlot.create(:time_slot => 20, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 21, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 22, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 23, :bookable => true, :count => 3, :booking_date => latest_booking)            

      BookingSlot.create(:time_slot => 28, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 29, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 30, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 31, :bookable => true, :count => 3, :booking_date => latest_booking)   
      BookingSlot.create(:time_slot => 32, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 33, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 34, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 35, :bookable => true, :count => 3, :booking_date => latest_booking) 

      BookingSlot.create(:time_slot => 38, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 39, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 40, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 41, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 42, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 43, :bookable => true, :count => 3, :booking_date => latest_booking)
    end

    while (Date.today + 1.month - 1.day) > BookingDate.all.maximum(:b_date) do
      BookingDate.create(:b_date => BookingDate.all.maximum(:b_date) + 1,
                         :bookable => true)
      latest_booking =  BookingDate.order("b_date DESC").first
      BookingSlot.create(:time_slot => 20, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 21, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 22, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 23, :bookable => true, :count => 3, :booking_date => latest_booking)            

      BookingSlot.create(:time_slot => 28, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 29, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 30, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 31, :bookable => true, :count => 3, :booking_date => latest_booking)   
      BookingSlot.create(:time_slot => 32, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 33, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 34, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 35, :bookable => true, :count => 3, :booking_date => latest_booking) 

      BookingSlot.create(:time_slot => 38, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 39, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 40, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 41, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 42, :bookable => true, :count => 3, :booking_date => latest_booking)
      BookingSlot.create(:time_slot => 43, :bookable => true, :count => 3, :booking_date => latest_booking)
    end

  end  
end
