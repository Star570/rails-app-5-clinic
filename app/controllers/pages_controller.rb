class PagesController < ApplicationController
  def announcements
    @announcements = Announcement.all.order("created_at DESC")    
  end

  def column
    @posts = Post.all.order("created_at DESC")
    @categories = Category.all.order("created_at ASC")
  end

  def message_board
    @messages = Message.all.order("created_at DESC")    
    @message = Message.new    
  end

  def booking
    
  end

end
