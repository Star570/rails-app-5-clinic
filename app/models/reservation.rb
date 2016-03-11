class Reservation < ActiveRecord::Base
  belongs_to :user    
  belongs_to :booking_slot  

  default_scope {joins(:booking_slot).order('booking_date DESC, time_slot ASC')}
  scope :to_be_served, -> { joins(:booking_slot).where("booking_date >= ?", Date.today) }
  scope :be_served, -> { joins(:booking_slot).where("booking_date <= ?", Date.today) }

  after_save :update_is_booked
  after_destroy :delete_is_booked     

  def send_add_reservation_mail(user)    
    UserMailer.notify_add_reservation(user, self).deliver_now if (user.email && !user.email.include?("example"))
  end  

  def send_cancel_reservation_mail(user)
    UserMailer.notify_cancel_reservation(user, self).deliver_now if (user.email && !user.email.include?("example"))
  end    

  def update_is_booked
    booking_slot.update(is_booked: true)
  end

  def delete_is_booked
    booking_slot.update(is_booked: false)
  end  
end
