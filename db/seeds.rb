puts "自動建立資料"

p "建立50名會員"
(1..50).to_a.each do |i|
  if i < 10 
    symbol = "0" + i.to_s
  else
    symbol = i.to_s
  end
  user = User.create(name: "陳"+symbol, 
                     phone: "09000000"+symbol, 
                     email: "chen"+symbol+"@gmail.com",                      
                     password: "12345", 
                     password_confirmation: "12345", 
                     admin: false, 
                     verified: true)
end 

# [20,21,22,23,28,29,30,31,32,33,34,35,38,39,40,41,42,43]
# 2/10~2/28 3/1~3/9
p "建立預約資料"

Reservation.create(user: User.find_by(name: "陳01"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 22, is_booked: false))
Reservation.create(user: User.find_by(name: "陳01"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,16), time_slot: 38, is_booked: false))
Reservation.create(user: User.find_by(name: "陳01"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,19), time_slot: 43, is_booked: false))

Reservation.create(user: User.find_by(name: "陳02"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 22, is_booked: false))
Reservation.create(user: User.find_by(name: "陳02"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,16), time_slot: 38, is_booked: false))
Reservation.create(user: User.find_by(name: "陳02"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,19), time_slot: 43, is_booked: false))

Reservation.create(user: User.find_by(name: "陳03"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 22, is_booked: false))
Reservation.create(user: User.find_by(name: "陳03"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,16), time_slot: 38, is_booked: false))
Reservation.create(user: User.find_by(name: "陳03"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,19), time_slot: 43, is_booked: false))


Reservation.create(user: User.find_by(name: "陳04"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 20, is_booked: false))
Reservation.create(user: User.find_by(name: "陳05"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 20, is_booked: false))
Reservation.create(user: User.find_by(name: "陳06"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 20, is_booked: false))

Reservation.create(user: User.find_by(name: "陳07"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 21, is_booked: false))
Reservation.create(user: User.find_by(name: "陳08"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 21, is_booked: false))
Reservation.create(user: User.find_by(name: "陳09"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 21, is_booked: false))

Reservation.create(user: User.find_by(name: "陳10"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 23, is_booked: false))
Reservation.create(user: User.find_by(name: "陳11"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 23, is_booked: false))
Reservation.create(user: User.find_by(name: "陳12"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,12), time_slot: 23, is_booked: false))

Reservation.create(user: User.find_by(name: "陳13"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,14), time_slot: 31, is_booked: false))

Reservation.create(user: User.find_by(name: "陳16"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,17), time_slot: 38, is_booked: false))

Reservation.create(user: User.find_by(name: "陳18"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,19), time_slot: 42, is_booked: false))

Reservation.create(user: User.find_by(name: "陳20"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,04,25), time_slot: 38, is_booked: false))

Reservation.create(user: User.find_by(name: "陳23"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,05,01), time_slot: 29, is_booked: false))

Reservation.create(user: User.find_by(name: "陳24"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,05,02), time_slot: 35, is_booked: false))

Reservation.create(user: User.find_by(name: "陳25"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,05,04), time_slot: 20, is_booked: false))

Reservation.create(user: User.find_by(name: "陳27"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,05, 8), time_slot: 40, is_booked: false))

Reservation.create(user: User.find_by(name: "陳29"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,05,22), time_slot: 32, is_booked: false))

Reservation.create(user: User.find_by(name: "陳30"), 
                   booking_slot: BookingSlot.find_by(booking_date: Date.new(2016,05,23), time_slot: 35, is_booked: false))