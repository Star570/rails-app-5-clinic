namespace :slot do
  desc "generate latest timeslot"

  task :generate => :environment do    

    if BookingSlot.all.empty?
      BookingSlot.available_slot.each do |t|
        if Date.today.wday == 0
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_date => Date.today)
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_date => Date.today)
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_date => Date.today)                    
        else
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_date => Date.today)
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_date => Date.today)
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_date => Date.today)                    
        end
      end
    end

    while (Date.today + 1.month - 1.day) > BookingSlot.all.maximum(:booking_date) do
      new_create_date = BookingSlot.all.maximum(:booking_date) + 1
      BookingSlot.available_slot.each do |t|
        if new_create_date.wday == 0
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_date => new_create_date)
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_date => new_create_date)
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_date => new_create_date)            
        else
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_date => new_create_date)
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_date => new_create_date)
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_date => new_create_date) 
        end
      end
    end
  end
end