class AnnouncementsController < ApplicationController

  before_action :find_announcement, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index

    @announcements = Announcement.all.order("created_at DESC")        
  end
  
  def show
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
      redirect_to announcements_path
    else
      render :edit
    end
  end

  def destroy
    @announcement.destroy
    flash[:notice] = "您已刪除公告"           
    redirect_to announcements_path
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :body)
  end

  def find_announcement
    @announcement = Announcement.find(params[:id])
  end

end
