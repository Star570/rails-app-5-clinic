class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.all.joins(:booking_slot).order("time_slot ASC")
  end

  def find
  end

  def list
    @reservations = Reservation.where(:name => params[:q])
  end  

  def new
    @reservation = Reservation.new
    if params[:slot] == "早上"
      @booking_slots = BookingDate.find_by(:b_date => params[:date]).booking_slots.morning.where("count > 0")
    elsif params[:slot] == "下午"
      @booking_slots = BookingDate.find_by(:b_date => params[:date]).booking_slots.afternoon.where("count > 0")         
    else
      @booking_slots = BookingDate.find_by(:b_date => params[:date]).booking_slots.evenning.where("count > 0")
    end

  end

  def create
    find_booking_slot = BookingSlot.find(params[:reservation][:booking_slot_id])
    if find_booking_slot.count > 0
      @reservation = Reservation.create(reservation_params)
      if @reservation.save
        redirect_to booking_path
      else 
        render :new
      end          
    else
      redirect_to booking_path
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])    
    @reservation.destroy
    redirect_to booking_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :booking_slot_id)
  end

end
