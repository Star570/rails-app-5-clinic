class BookingSlot < ActiveRecord::Base
  has_many :reservations #dont destroy the reservation info. when delete booking slot

  scope :morning,   -> { where("time_slot < 24") }    
  scope :afternoon, -> { where("time_slot >= 24 and time_slot < 36") }       
  scope :evenning,   -> { where("time_slot >= 36") }         

  scope :hand,   -> { where("booking_type = 0") }     
  scope :body,   -> { where("booking_type = 1") }       

  default_scope {order('booking_date ASC, time_slot ASC, is_booked DESC, bookable DESC')}

  def self.available_hand_slot
    [20,21,22,23,28,29,30,31,32,33,34,35,38,39,40,41,42,43]
  end

  def self.available_body_slot
    [20,22,28,30,32,34,38,40,42]
  end

end
