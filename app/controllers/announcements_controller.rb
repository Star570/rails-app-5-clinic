class AnnouncementsController < ApplicationController

  before_action :find_announcement, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    if logged_in_as_admin?
      @announcements = Announcement.page(params[:page]).per(10)  
      @announcements_count = Announcement.count      
    else
      @announcements = Announcement.where("seeable = ?", true).page(params[:page]).per(10)       
      @announcements_count = Announcement.where("seeable = ?", true).count            
    end        
  end
  
  def show
    if logged_in_as_admin?
      @announcements_count = Announcement.count      
    else
      @announcements_count = Announcement.where("seeable = ?", true).count            
    end            
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.create(announcement_params)
    @announcement.user = current_user
    if @announcement.save
      flash[:notice] = "您已發佈一篇新公告"           
      redirect_to announcements_path
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @announcement.update(announcement_params)
      flash[:notice] = "您已修改公告"                 
      redirect_to announcement_path(@announcement)
    else
      render :edit
    end
  end

  def destroy
    @announcement.destroy
    flash[:notice] = "您已刪除公告"           
    redirect_to announcements_path
  end

  def modify_seeable
    @announcement = Announcement.find(params[:announcement])   
    if @announcement.seeable 
      @announcement.update(seeable: false)
    else
      @announcement.update(seeable: true)
    end      
    redirect_back_or_to root_path
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :body)
  end

  def find_announcement
    @announcement = Announcement.find(params[:id])
  end

end
