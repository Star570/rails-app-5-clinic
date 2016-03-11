class ReservationsController < ApplicationController
  before_action :require_user_or_admin, except: [:index, :modify_seeable]  
  before_action :require_admin, only: [:modify_seeable]    
  before_action :find_reservation, only: [:edit, :update, :destroy]  

  def hand
    @booking_slots = BookingSlot.hand.where("booking_date <= ?", Date.today + 2.month)   
  end
  
  def new_hand
    @reservation = Reservation.new
    if params[:slot] == "上午"
      @booking_slots = BookingSlot.hand.where("booking_date = ? and bookable = ? and is_booked = ?", params[:date], true, false).morning.group_by{|b| b.time_slot}
    elsif params[:slot] == "下午"
      @booking_slots = BookingSlot.hand.where("booking_date = ? and bookable = ? and is_booked = ?", params[:date], true, false).afternoon.group_by{|b| b.time_slot}      
    else
      @booking_slots = BookingSlot.hand.where("booking_date = ? and bookable = ? and is_booked = ?", params[:date], true, false).evenning.group_by{|b| b.time_slot}
    end
  end

  def create_hand
    find_booking_slot = BookingSlot.find(params[:reservation][:booking_slot_id])

    book_less_than_seven_day = current_user.reservations.any? do |r|
       r.booking_slot.booking_type == 0 && (find_booking_slot.booking_date - r.booking_slot.booking_date).to_i.abs <= 7
    end   

    book_body_same_day = current_user.reservations.any? do |r|
       r.booking_slot.booking_type == 1 &&  (find_booking_slot.booking_date == r.booking_slot.booking_date)
    end      

    if find_booking_slot.is_booked
      flash[:alert] = "此名額剛已被預約，請重選。"
      redirect_to hand_reservations_path   
    elsif !find_booking_slot.bookable
      flash[:alert] = "此名額已被保留，請重選。"
      redirect_to hand_reservations_path                   
    else
      if book_less_than_seven_day
        flash[:alert] = "七天內不可重複預約手療，若需預約兩位以上，請致電預約。"
        redirect_to hand_reservations_path  
      elsif book_body_same_day
        flash[:alert] = "當日已有預約體雕。"
        redirect_to hand_reservations_path  
      else 
        @reservation = Reservation.create(reservation_params)
        @reservation.user = current_user

        if @reservation.save
          find_booking_slot.update(is_booked: true)
          @reservation.send_add_reservation_mail(@reservation.user)
          flash[:notice] = "已新增一筆手療預約"
          redirect_to finish_reservations_path(:date => find_booking_slot.booking_date, :slot => find_booking_slot.time_slot, :reservation => @reservation)
        else 
          # possible problem/bug here
          render :new
        end   
      end
    end
  end

  def body
    @booking_slots = BookingSlot.body.where("booking_date <= ?", Date.today + 2.month)   
  end
  
  def new_body
    @reservation = Reservation.new
    if params[:slot] == "上午"
      @booking_slots = BookingSlot.body.where("booking_date = ? and bookable = ? and is_booked = ?", params[:date], true, false).morning.group_by{|b| b.time_slot}
    elsif params[:slot] == "下午"
      @booking_slots = BookingSlot.body.where("booking_date = ? and bookable = ? and is_booked = ?", params[:date], true, false).afternoon.group_by{|b| b.time_slot}      
    else
      @booking_slots = BookingSlot.body.where("booking_date = ? and bookable = ? and is_booked = ?", params[:date], true, false).evenning.group_by{|b| b.time_slot}
    end
  end

  def create_body
    find_booking_slot = BookingSlot.find(params[:reservation][:booking_slot_id])

    book_less_than_seven_day = current_user.reservations.any? do |r|
      r.booking_slot.booking_type == 1 && (find_booking_slot.booking_date - r.booking_slot.booking_date).to_i.abs <= 7
    end   

    book_body_same_day = current_user.reservations.any? do |r|
      r.booking_slot.booking_type == 0 && (find_booking_slot.booking_date == r.booking_slot.booking_date)
    end      

    if find_booking_slot.is_booked
      flash[:alert] = "此名額剛已被預約，請重選。"
      redirect_to body_reservations_path   
    elsif !find_booking_slot.bookable
      flash[:alert] = "此名額已被保留，請重選。"
      redirect_to body_reservations_path                   
    else
      if book_less_than_seven_day
        flash[:alert] = "七天內不可重複預約體雕，若需預約兩位以上，請致電預約。"
        redirect_to body_reservations_path  
      elsif book_body_same_day
        flash[:alert] = "當日已有預約手療。"
        redirect_to body_reservations_path  
      else 
        @reservation = Reservation.create(reservation_params)
        @reservation.user = current_user

        if @reservation.save
          find_booking_slot.update(is_booked: true)
          @reservation.send_add_reservation_mail(@reservation.user)
          flash[:notice] = "已新增一筆體雕預約"
          redirect_to finish_reservations_path(:date => find_booking_slot.booking_date, :slot => find_booking_slot.time_slot, :reservation => @reservation)
        else 
          # possible problem/bug here
          render :new
        end   
      end
    end
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      flash[:notice] = "您已修改症狀描述"           
      redirect_to show_user_reservations_path
    else
      render :edit
    end    
  end

  def destroy
    find_booking_slot = @reservation.booking_slot
    @reservation.send_cancel_reservation_mail(@reservation.user)    
    @reservation.destroy
    find_booking_slot.update(is_booked: false) 
    flash[:notice] = "已刪除預約"
    redirect_back_or_to root_path
  end

  def show_user   
  end

  def finish  
    @reservation = Reservation.find(params[:reservation]) 
  end

  private

  def reservation_params
    params.require(:reservation).permit(:booking_slot_id, :desc)
  end

  def find_reservation
    @reservation = Reservation.find(params[:id]) 
  end  

end
