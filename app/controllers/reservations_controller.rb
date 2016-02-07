class ReservationsController < ApplicationController

  def index
    BookingDate.update_latest_booking
    @booking_dates = BookingDate.all    
  end

  def overall
    @reservations = Reservation.all.joins(:booking_slot).order("time_slot ASC")
  end

  def find
  end

  def list
    @reservations = Reservation.where(:name => params[:q])
  end  

  def new
    @reservation = Reservation.new
    find_booking_date = BookingDate.find_by(:b_date => params[:date])
    if params[:slot] == "早上"
      @booking_slots = find_booking_date.booking_slots.morning.where("count > 0").order("time_slot ASC")
    elsif params[:slot] == "下午"
      @booking_slots = find_booking_date.booking_slots.afternoon.where("count > 0").order("time_slot ASC")         
    else
      @booking_slots = find_booking_date.booking_slots.evenning.where("count > 0").order("time_slot ASC")
    end

  end

  def create
    find_booking_slot = BookingSlot.find(params[:reservation][:booking_slot_id])
    if find_booking_slot.count > 0
      @reservation = Reservation.create(reservation_params)
      if @reservation.save
        redirect_to reservations_path
      else 
        find_booking_date = find_booking_slot.booking_date
        params[:date] = find_booking_date.b_date        
        if find_booking_slot.time_slot < 24
          @booking_slots = find_booking_date.booking_slots.morning.where("count > 0").order("time_slot ASC")
          params[:slot] = "早上"
        elsif find_booking_slot.time_slot >= 36
          @booking_slots = find_booking_date.booking_slots.evenning.where("count > 0").order("time_slot ASC")          
          params[:slot] = "晚上"
        else
          @booking_slots = find_booking_date.booking_slots.afternoon.where("count > 0").order("time_slot ASC")         
          params[:slot] = "下午"
        end        
        render :new
      end          
    else
      redirect_to reservations_path
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])    
    @reservation.destroy
    redirect_to :back
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :phone, :booking_slot_id)
  end

end
