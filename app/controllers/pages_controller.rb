class PagesController < ApplicationController
  before_action :require_admin

  def reservation_all
    if params[:start_date] == nil
      @booking_slots = BookingSlot.where("booking_date >= ? and booking_date <= ?", 
                                         Date.today.beginning_of_month.beginning_of_week, 
                                         Date.today.end_of_month.end_of_week)                                                 
    else
      @booking_slots = BookingSlot.where("booking_date >= ? and booking_date <= ?", 
                                         Date.parse(params[:start_date]).beginning_of_month.beginning_of_week, 
                                         Date.parse(params[:start_date]).end_of_month.end_of_week)              
    end

    @booking_slots_hash = Hash.new
    @booking_slots.each do |b|
      if @booking_slots_hash[b.booking_date] == nil
        @booking_slots_hash[b.booking_date] = [0,0,0,0,0,0] #is_booked 早中晚 + bookable & !is_booked早中晚          
      end

      if b.time_slot < 24 && b.is_booked == true
        @booking_slots_hash[b.booking_date][0] += 1
      elsif b.time_slot >= 24 and b.time_slot < 36 and b.is_booked == true
        @booking_slots_hash[b.booking_date][1] += 1
      elsif b.time_slot >= 36 and b.is_booked == true
        @booking_slots_hash[b.booking_date][2] += 1
      elsif b.time_slot < 24 and b.bookable == false and b.is_booked == false
        @booking_slots_hash[b.booking_date][3] += 1
      elsif b.time_slot >= 24 and b.time_slot < 36 and b.bookable == false and b.is_booked == false
        @booking_slots_hash[b.booking_date][4] += 1
      elsif b.time_slot >= 36 and b.bookable == false and b.is_booked == false
        @booking_slots_hash[b.booking_date][5] += 1
      end                              
    end

  end

  def reservation_list    
    @reservations_by_created_at_count = Reservation.count
    @reservations_by_created_at = Reservation.unscoped.joins(:booking_slot).order('created_at DESC').page(params[:page]).per(10)     
  end

  def reservation_week
    @dayOfWeek  = [ "日", "一", "二", "三", "四", "五", "六" ]
    @date = Date.parse(params[:date])

    @booking_slots_pre = BookingSlot.where("booking_date >=? and booking_date < ?", @date-9, @date-2)
    @booking_dates_pre_count = @booking_slots_pre.map(&:booking_date).uniq.count

    @booking_slots_nxt = BookingSlot.where("booking_date >=? and booking_date < ?", @date+5, @date+12)
    @booking_dates_nxt_count = @booking_slots_nxt.map(&:booking_date).uniq.count

    @booking_slots = BookingSlot.where("booking_date >=? and booking_date < ?", @date-2, @date+5)
    @booking_slots_hash = Hash.new    
    @booking_dates = @booking_slots.map(&:booking_date).uniq    

    @booking_slots.each do |b|

      if @booking_slots_hash[b.booking_date] == nil
        @booking_slots_hash[b.booking_date] =  Hash.new    
      end
      if @booking_slots_hash[b.booking_date][b.time_slot] == nil
        @booking_slots_hash[b.booking_date][b.time_slot] =  Array.new
      end
      if b.is_booked
        @booking_slots_hash[b.booking_date][b.time_slot] << b.reservations.first.user
      elsif b.bookable
        @booking_slots_hash[b.booking_date][b.time_slot] << [1, b]
      else
        @booking_slots_hash[b.booking_date][b.time_slot] << [0, b]
      end               
    end

  end

  def user_all
    @total_user_count = User.count

    @admin_member = User.where("admin = ?", true)
    @verified_member = User.where("verified = ? and admin = ?", true, false).page(params[:page]).per(10)     
    @not_verified_member = User.where("verified = ? and admin = ?", false, false)

    @admin_member_count = User.where("admin = ?", true).count        
    @verified_member_count = User.where("verified = ? and admin = ?", true, false).count
    @not_verified_member_count = User.where("verified = ? and admin = ?", false, false).count  

  end

  def user_show
    @user = User.find(params[:user])
  end

  def add_user
    @user = User.new        
  end 

  def search_user
    if params[:search]
      search_string = {:name_or_phone_or_email_cont => params[:search]}
      @users = User.search(search_string).result.order("admin DESC, created_at DESC")
    end
  end 

  def modify_bookable
    @booking_slot = BookingSlot.find(params[:booking_slot].to_i)   
    if (params[:bookable] == "false") && (@booking_slot.is_booked)
      flash[:alert] = "此時段剛被註冊"    
      redirect_back_or_to backstage_reservation_week_path(date: Date.today) 
    else
      if params[:bookable] == "false"
        @booking_slot.update(bookable: false)
      else
        @booking_slot.update(bookable: true)
      end
      respond_to do |format|
        format.js
      end
    end
    #redirect_back_or_to root_path
  end

  def create_user
    find_user_by_email = User.find_by(email: user_params[:email]) unless user_params[:email] == "example@gmail.com"
    find_user_by_phone = User.find_by(phone: user_params[:phone])    
    if find_user_by_email
      flash[:alert] = "此會員郵箱已經註冊過"     
      redirect_back_or_to root_path
    elsif find_user_by_phone
      flash[:alert] = "此會員手機已經註冊過"     
      redirect_back_or_to root_path     
    else
      @user = User.new(user_params)
      @user.admin = false
      if @user.save
        flash[:notice] = "新增會員#{@user.name}成功."  
        @user.generate_pin   
        redirect_to backstage_user_all_path
      else
        render :add_user
      end
    end     
  end  

  def add_reservation_s1 #select date
    @user = User.find(params[:user].to_i)
    @booking_slots = BookingSlot.all         
  end  

  def add_reservation_s2 #select time_slot
    @reservation = Reservation.new
    @user = User.find(params[:user].to_i)

    # for Admin, no need to check bookable
    if params[:slot] == "上午"
      @booking_slots = BookingSlot.where("booking_date = ? and is_booked = ?", params[:date], false).morning.group_by{|b| b.time_slot}
    elsif params[:slot] == "下午"
      @booking_slots = BookingSlot.where("booking_date = ? and is_booked = ?", params[:date], false).afternoon.group_by{|b| b.time_slot}      
    else
      @booking_slots = BookingSlot.where("booking_date = ? and is_booked = ?", params[:date], false).evenning.group_by{|b| b.time_slot}
    end    
  end  

  def create_reservation #finish reservation
    find_booking_slot = BookingSlot.find(params[:reservation][:booking_slot_id])
    find_user = User.find(params[:user].to_i)

    book_less_than_three_day = find_user.reservations.any? do |r|
      (find_booking_slot.booking_date - r.booking_slot.booking_date).to_i.abs <= 3
    end      

    if find_booking_slot.is_booked
      flash[:alert] = "此名額剛已被預約, 請重選"
      redirect_to backstage_add_reservation_s1_path(user: params[:user])           
    else
      @reservation = Reservation.create(reservation_params)
      @reservation.user = find_user

      if @reservation.save
        find_booking_slot.update(is_booked: true)
        @reservation.send_add_reservation_mail(find_user)
        if book_less_than_three_day
          flash[:alert] = "已新增預約, 此顧客三日內有其他預約, 請確認"          
        else
          flash[:notice] = "已新增預約"
        end
        redirect_to backstage_add_reservation_s3_path(:user => @reservation.user, :date => find_booking_slot.booking_date, :slot => find_booking_slot.time_slot)
      else 
        # possible problem/bug here
        render :add_reservation_s2
      end  
    end               
  end  

  def add_reservation_s3 #finish reservation
    @user = User.find(params[:user].to_i)
  end  

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :be_admin, :pin)
  end

  def reservation_params
    params.require(:reservation).permit(:booking_slot_id)
  end  
end
