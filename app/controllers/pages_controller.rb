class PagesController < ApplicationController
  before_action :require_admin

  def hand_reservation_month
    if params[:start_date] == nil
      @booking_slots = BookingSlot.hand.where("booking_date >= ? and booking_date <= ?", 
                                         Date.today.beginning_of_month.beginning_of_week, 
                                         Date.today.end_of_month.end_of_week)                                                 
    else
      @booking_slots = BookingSlot.hand.where("booking_date >= ? and booking_date <= ?", 
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

  def hand_reservation_list    
    @reservations_by_created_at_count = Reservation.joins(:booking_slot).where("booking_type = 0").count
    @reservations_by_created_at = Reservation.unscoped.joins(:booking_slot).where("booking_type = 0").order('created_at DESC').page(params[:page]).per(30)     
  end

  def hand_reservation_week
    @dayOfWeek  = [ "日", "一", "二", "三", "四", "五", "六" ]
    @date = Date.parse(params[:date])

    @booking_slots_pre = BookingSlot.hand.where("booking_date >=? and booking_date < ?", @date.beginning_of_week-7, @date.beginning_of_week-0)
    @booking_dates_pre_count = @booking_slots_pre.map(&:booking_date).uniq.count

    @booking_slots_nxt = BookingSlot.hand.where("booking_date >=? and booking_date < ?", @date.beginning_of_week+7, @date.beginning_of_week+14)
    @booking_dates_nxt_count = @booking_slots_nxt.map(&:booking_date).uniq.count

    @booking_slots = BookingSlot.hand.where("booking_date >=? and booking_date < ?", @date.beginning_of_week, @date.beginning_of_week+7)
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

  def body_reservation_month
    if params[:start_date] == nil
      @booking_slots = BookingSlot.body.where("booking_date >= ? and booking_date <= ?", 
                                         Date.today.beginning_of_month.beginning_of_week, 
                                         Date.today.end_of_month.end_of_week)                                                 
    else
      @booking_slots = BookingSlot.body.where("booking_date >= ? and booking_date <= ?", 
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

  def body_reservation_list    
    @reservations_by_created_at_count = Reservation.joins(:booking_slot).where("booking_type = 1").count
    @reservations_by_created_at = Reservation.unscoped.joins(:booking_slot).where("booking_type = 1").order('created_at DESC').page(params[:page]).per(30)     
  end

  def body_reservation_week
    @dayOfWeek  = [ "日", "一", "二", "三", "四", "五", "六" ]
    @date = Date.parse(params[:date])

    @booking_slots_pre = BookingSlot.body.where("booking_date >=? and booking_date < ?", @date.beginning_of_week-7, @date.beginning_of_week-0)
    @booking_dates_pre_count = @booking_slots_pre.map(&:booking_date).uniq.count

    @booking_slots_nxt = BookingSlot.body.where("booking_date >=? and booking_date < ?", @date.beginning_of_week+7, @date.beginning_of_week+14)
    @booking_dates_nxt_count = @booking_slots_nxt.map(&:booking_date).uniq.count

    @booking_slots = BookingSlot.body.where("booking_date >=? and booking_date < ?", @date.beginning_of_week, @date.beginning_of_week+7)
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
    @verified_member = User.where("verified = ? and admin = ?", true, false).page(params[:page]).per(20)     
    @not_verified_member = User.where("verified = ? and admin = ?", false, false)
    @black_member = User.where("black = ?", true)    

    @admin_member_count = User.where("admin = ?", true).count        
    @verified_member_count = User.where("verified = ? and admin = ?", true, false).count
    @not_verified_member_count = User.where("verified = ? and admin = ?", false, false).count  
    @black_member_count = User.where("black = ?", true).count  

  end

  def user_show
    @user = User.find(params[:user])
  end

  def add_user
    @user = User.new        
  end 

  def search_user
    if params[:search]
      search_string = {:name_or_phone_or_email_or_home_pre_or_home_post_cont => params[:search]}
      @users = User.search(search_string).result.order("admin DESC, created_at DESC").page(params[:page]).per(10)    
    end
  end 

  def modify_hand_bookable
    if params[:booking_slot] == "yes"
      BookingSlot.hand.where(booking_date: params[:date]).update_all(bookable: true)
      redirect_to backstage_hand_reservation_week_path(date: params[:date]) 
    elsif params[:booking_slot] == "no"
      BookingSlot.hand.where(booking_date: params[:date]).update_all(bookable: false)
      redirect_to backstage_hand_reservation_week_path(date: params[:date]) 
    else
      @booking_slot = BookingSlot.find(params[:booking_slot].to_i)   
      if (params[:bookable] == "false") && (@booking_slot.is_booked)
        flash[:alert] = "此時段剛被註冊。"    
        redirect_back_or_to backstage_hand_reservation_week_path(date: Date.today) 
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
    end

    #redirect_back_or_to root_path
  end

  def modify_body_bookable
    if params[:booking_slot] == "yes"
      BookingSlot.body.where(booking_date: params[:date]).update_all(bookable: true)
      redirect_to backstage_body_reservation_week_path(date: params[:date]) 
    elsif params[:booking_slot] == "no"
      BookingSlot.body.where(booking_date: params[:date]).update_all(bookable: false)
      redirect_to backstage_body_reservation_week_path(date: params[:date]) 
    else
      @booking_slot = BookingSlot.find(params[:booking_slot].to_i)   
      if (params[:bookable] == "false") && (@booking_slot.is_booked)
        flash[:alert] = "此時段剛被註冊。"    
        redirect_back_or_to backstage_body_reservation_week_path(date: Date.today) 
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
    end

    #redirect_back_or_to root_path
  end  

  def create_user
    @user = User.new(user_params)
    @user.admin = false
    @user.home_pre = params["home_pre"]
    @user.home_post = params["home_post"]    
    find_home_exist = params["home_post"]!= "" && User.find_by(home_post: params["home_post"])
    
    if @user.phone == "" && @user.email == "" && @user.home_post == ""
      flash[:alert] = "Email與手機或市話不可全部空白。"        
      render :add_user      
    elsif find_home_exist
      flash[:alert] = "市話已經存在。"        
      render :add_user        
    elsif @user.save
      flash[:notice] = "新增會員#{@user.name}成功。"  
      redirect_to backstage_user_all_path
    else
      render :add_user
    end        
  end  

  def add_hand_reservation_s1 #select date
    @user = User.find(params[:user])
    @booking_slots = BookingSlot.hand         
  end  

  def add_hand_reservation_s2 #select time_slot
    @reservation = Reservation.new
    @user = User.find(params[:user])

    # for Admin, no need to check bookable
    if params[:slot] == "上午"
      @booking_slots = BookingSlot.hand.where("booking_date = ? and is_booked = ?", params[:date], false).morning.group_by{|b| b.time_slot}
    elsif params[:slot] == "下午"
      @booking_slots = BookingSlot.hand.where("booking_date = ? and is_booked = ?", params[:date], false).afternoon.group_by{|b| b.time_slot}      
    else
      @booking_slots = BookingSlot.hand.where("booking_date = ? and is_booked = ?", params[:date], false).evenning.group_by{|b| b.time_slot}
    end    
  end  

  def create_hand_reservation #finish reservation
    find_booking_slot = BookingSlot.find(params[:reservation][:booking_slot_id])
    find_user = User.find(params[:user])

    book_less_than_seven_day = find_user.reservations.any? do |r|
      r.booking_slot.booking_type == 0 && (find_booking_slot.booking_date - r.booking_slot.booking_date).to_i.abs <= 7
    end      

    book_body_same_day = find_user.reservations.any? do |r|
      r.booking_slot.booking_type == 1 && (find_booking_slot.booking_date == r.booking_slot.booking_date)
    end    


    if find_booking_slot.is_booked
      flash[:alert] = "此名額剛已被預約，請重選。"
      redirect_to backstage_add_hand_reservation_s1_path(user: params[:user])           
    else
      @reservation = Reservation.create(reservation_params)
      @reservation.user = find_user

      if @reservation.save
        find_booking_slot.update(is_booked: true)
        @reservation.send_add_reservation_mail(find_user)
        if book_less_than_seven_day
          flash[:alert] = "已新增一筆手療預約，此顧客七日內有其他預約, 請確認。"          
        elsif book_body_same_day
          flash[:alert] = "已新增一筆手療預約，此顧客當日內有預約體雕, 請確認。"                
        else
          flash[:notice] = "已新增一筆手療預約。"
        end
        redirect_to backstage_add_hand_reservation_s3_path(:user => @reservation.user, :date => find_booking_slot.booking_date, :slot => find_booking_slot.time_slot)
      else 
        # possible problem/bug here
        render :add_hand_reservation_s2
      end  
    end               
  end  

  def add_hand_reservation_s3 #finish reservation
    @user = User.find(params[:user])
  end  

  def edit_hand_reservation
    @reservation = Reservation.find(params[:r])
  end

  def update_hand_reservation
    @reservation = Reservation.find(params[:r])
    if @reservation.update(reservation_params)
      flash[:notice] = "您已修改症狀描述。"           
      redirect_to backstage_hand_reservation_list_path
    else
      render :edit
    end        
  end  

  def add_body_reservation_s1 #select date
    @user = User.find(params[:user])
    @booking_slots = BookingSlot.body         
  end  

  def add_body_reservation_s2 #select time_slot
    @reservation = Reservation.new
    @user = User.find(params[:user])

    # for Admin, no need to check bookable
    if params[:slot] == "上午"
      @booking_slots = BookingSlot.body.where("booking_date = ? and is_booked = ?", params[:date], false).morning.group_by{|b| b.time_slot}
    elsif params[:slot] == "下午"
      @booking_slots = BookingSlot.body.where("booking_date = ? and is_booked = ?", params[:date], false).afternoon.group_by{|b| b.time_slot}      
    else
      @booking_slots = BookingSlot.body.where("booking_date = ? and is_booked = ?", params[:date], false).evenning.group_by{|b| b.time_slot}
    end    
  end  

  def create_body_reservation #finish reservation
    find_booking_slot = BookingSlot.find(params[:reservation][:booking_slot_id])
    find_user = User.find(params[:user])

    book_less_than_seven_day = find_user.reservations.any? do |r|
      r.booking_slot.booking_type == 1 && (find_booking_slot.booking_date - r.booking_slot.booking_date).to_i.abs <= 7
    end      

    book_body_same_day = find_user.reservations.any? do |r|
      r.booking_slot.booking_type == 0 && (find_booking_slot.booking_date == r.booking_slot.booking_date)
    end    


    if find_booking_slot.is_booked
      flash[:alert] = "此名額剛已被預約，請重選。"
      redirect_to backstage_add_body_reservation_s1_path(user: params[:user])           
    else
      @reservation = Reservation.create(reservation_params)
      @reservation.user = find_user

      if @reservation.save
        find_booking_slot.update(is_booked: true)
        @reservation.send_add_reservation_mail(find_user)
        if book_less_than_seven_day
          flash[:alert] = "已新增一筆體雕預約，此顧客七日內有其他預約，請確認。"          
        elsif book_body_same_day
          flash[:alert] = "已新增一筆體雕預約，此顧客當日內有預約手療，請確認。"                
        else
          flash[:notice] = "已新增一筆體雕預約。"
        end
        redirect_to backstage_add_body_reservation_s3_path(:user => @reservation.user, :date => find_booking_slot.booking_date, :slot => find_booking_slot.time_slot)
      else 
        # possible problem/bug here
        render :add_body_reservation_s2
      end  
    end               
  end  

  def add_body_reservation_s3 #finish reservation
    @user = User.find(params[:user])
  end  

  def edit_body_reservation
    @reservation = Reservation.find(params[:r])
  end

  def update_body_reservation
    @reservation = Reservation.find(params[:r])
    if @reservation.update(reservation_params)
      flash[:notice] = "您已修改症狀描述。"           
      redirect_to backstage_body_reservation_list_path
    else
      render :edit
    end        
  end  

  def print_hand_reservation
    @dayOfWeek  = [ "日", "一", "二", "三", "四", "五", "六" ]
    @date = Date.parse(params[:date])
    @booking_dates = (@date.beginning_of_week..@date.beginning_of_week + 6).to_a    

    @booking_slots = BookingSlot.hand.where("booking_date >=? and booking_date < ? and is_booked = ?", @date.beginning_of_week, @date.beginning_of_week+7, true)
  end

  def print_body_reservation
    @dayOfWeek  = [ "日", "一", "二", "三", "四", "五", "六" ]
    @date = Date.parse(params[:date])
    @booking_dates = (@date.beginning_of_week..@date.beginning_of_week + 6).to_a    

    @booking_slots = BookingSlot.body.where("booking_date >=? and booking_date < ? and is_booked = ?", @date.beginning_of_week, @date.beginning_of_week+7, true)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :home_pre, :home_post, :password, :password_confirmation, :verified)
  end

  def reservation_params
    params.require(:reservation).permit(:booking_slot_id, :desc)
  end  

end
