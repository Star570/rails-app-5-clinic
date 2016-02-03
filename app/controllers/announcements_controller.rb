class AnnouncementsController < ApplicationController

  before_action :find_announcement, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.create(announcement_params)
    if @announcement.save
      redirect_to news_path
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @announcement.update(announcement_params)
      redirect_to news_path
    else
      render :edit
    end
  end

  def destroy
    @announcement.destroy
    redirect_to news_path
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :body)
  end

  def find_announcement
    @announcement = Announcement.find(params[:id])
  end

end
