class BookingSlot < ActiveRecord::Base
  has_many :reservations #dont destroy the reservation info. when delete booking slot
  belongs_to :booking_date

  scope :morning,   -> { where("time_slot < 24") }    
  scope :afternoon, -> { where("time_slot >= 24 and time_slot < 36") }       
  scope :evenning,   -> { where("time_slot >= 36") }         
end
