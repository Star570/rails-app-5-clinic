class ReservationsController < ApplicationController
  before_action :require_user, except: [:index, :find, :destroy]
  before_action :require_user_or_admin, only: [:destroy]  
  before_action :require_admin, only: [:find]

  def index
    @booking_slots = BookingSlot.all    
  end
  
  def new
    @reservation = Reservation.new
    if params[:slot] == "上午"
      @booking_slots = BookingSlot.where("booking_date = ? and bookable = ? and is_booked = ?", params[:date], true, false).morning.group_by{|b| b.time_slot}
    elsif params[:slot] == "下午"
      @booking_slots = BookingSlot.where("booking_date = ? and bookable = ? and is_booked = ?", params[:date], true, false).afternoon.group_by{|b| b.time_slot}      
    else
      @booking_slots = BookingSlot.where("booking_date = ? and bookable = ? and is_booked = ?", params[:date], true, false).evenning.group_by{|b| b.time_slot}
    end
  end

  def create
    find_booking_slot = BookingSlot.find(params[:reservation][:booking_slot_id])

    book_less_than_three_day = current_user.reservations.any? do |r|
      (find_booking_slot.booking_date - r.booking_slot.booking_date).to_i.abs <= 3
    end      

    if find_booking_slot.is_booked
      flash[:alert] = "此名額剛已被預約, 請重選"
      redirect_to reservations_path   
    elsif !find_booking_slot.bookable
      flash[:alert] = "此名額已被保留, 請重選"
      redirect_to reservations_path                   
    else
      if !book_less_than_three_day
        @reservation = Reservation.create(reservation_params)
        @reservation.user = current_user

        if @reservation.save
          find_booking_slot.update(is_booked: true)
          @reservation.send_add_reservation_mail(current_user)
          flash[:notice] = "已新增預約"
          redirect_to finish_reservations_path(:date => find_booking_slot.booking_date, :slot => find_booking_slot.time_slot)
        else 
          # possible problem/bug here
          render :new
        end          
      else 
        flash[:alert] = "三天內不可重複預約"
        redirect_to reservations_path      
      end
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id]) 
    find_booking_slot = @reservation.booking_slot
    @reservation.send_cancel_reservation_mail(current_user)    
    @reservation.destroy
    find_booking_slot.update(is_booked: false) 
    flash[:notice] = "已刪除預約"
    redirect_back_or_to root_path
  end

  def show_user   
  end

  def finish  
  end

  private

  def reservation_params
    params.require(:reservation).permit(:booking_slot_id)
  end

end
