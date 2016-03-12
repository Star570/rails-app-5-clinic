namespace :slot do
  desc "generate timeslot"
  
  task :generate => :environment do  
    p Time.now  
    p "generate latest hand timeslot"

    if BookingSlot.hand.empty?
      BookingSlot.available_hand_slot.each do |t|
        if Date.today.wday == 0
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_type => 0, :booking_date => Date.today - 7)
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_type => 0, :booking_date => Date.today - 7)
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_type => 0, :booking_date => Date.today - 7)                    
        else
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_type => 0, :booking_date => Date.today - 7)
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_type => 0, :booking_date => Date.today - 7)
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_type => 0, :booking_date => Date.today - 7)                    
        end
      end
    end

    while (Date.today + 12.month - 1.day) > BookingSlot.hand.maximum(:booking_date) do
      new_create_date = BookingSlot.hand.maximum(:booking_date) + 1
      BookingSlot.available_hand_slot.each do |t|
        if new_create_date.wday == 0
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_type => 0, :booking_date => new_create_date)
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_type => 0, :booking_date => new_create_date)
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_type => 0, :booking_date => new_create_date)            
        else
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_type => 0, :booking_date => new_create_date)
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_type => 0, :booking_date => new_create_date)
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_type => 0, :booking_date => new_create_date) 
        end
      end
    end

    p "generate latest body timeslot"
    if BookingSlot.body.empty?
      BookingSlot.available_body_slot.each do |t|
        if Date.today.wday == 0
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_type => 1, :booking_date => Date.today - 7)                  
        else
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_type => 1, :booking_date => Date.today - 7)
        end
      end
    end

    while (Date.today + 12.month - 1.day) > BookingSlot.body.maximum(:booking_date) do
      new_create_date = BookingSlot.body.maximum(:booking_date) + 1
      BookingSlot.available_body_slot.each do |t|
        if new_create_date.wday == 0
          BookingSlot.create(:time_slot => t, :bookable => false, :booking_type => 1, :booking_date => new_create_date)          
        else
          BookingSlot.create(:time_slot => t, :bookable => true,  :booking_type => 1, :booking_date => new_create_date)
        end
      end
    end

  p "remove block list"
    User.where("black = ?", true).each do |u|
      if Date.today > u.black_date
        u.update(black: false)
      end
    end

  end
end