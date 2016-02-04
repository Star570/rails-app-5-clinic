class Reservation < ActiveRecord::Base
  belongs_to :booking_slot
  validates :name, presence: true, length: { maximum: 10 }   
  validates :phone, presence: true, numericality: true, length: { minimum: 10, maximum: 10 }   

  validates_each :phone do |record, attr, value|
    record.errors.add(attr, '此非手機號碼') if value[0] != "0" || value[1] != "9"
  end

  after_save :update_booking_count
  after_destroy :update_booking_count  

  def update_booking_count
    find_booking_slot = self.booking_slot
    find_booking_slot.count = 3 - self.booking_slot.reservations.count
    find_booking_slot.save
  end
end
