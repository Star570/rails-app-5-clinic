class Reservation < ActiveRecord::Base
  belongs_to :booking_slot
  validates :name, :phone, presence: true, length: { maximum: 10 }   
  validates :phone, numericality: true

  after_save :update_booking_count
  after_destroy :update_booking_count  

  def update_booking_count
    find_booking_slot = self.booking_slot
    find_booking_slot.count = 3 - self.booking_slot.reservations.count
    find_booking_slot.save
  end
end
