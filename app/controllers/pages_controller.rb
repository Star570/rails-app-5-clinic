class PagesController < ApplicationController
  def announcements
    flash[:notice] = "Hello"       
    @announcements = Announcement.all.order("created_at DESC")    
  end

  def column
    flash[:notice] = "Hello"        
    @posts = Post.all.order("created_at DESC")
    @categories = Category.all.order("created_at ASC")
  end

  def message_board
    flash[:notice] = "Hello"        
    @messages = Message.all.order("created_at DESC")    
    @message = Message.new    
  end

  def booking
    flash[:notice] = "Hello"        
    BookingDate.update_latest_booking
    @booking_dates = BookingDate.all
  end

end
