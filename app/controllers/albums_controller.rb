class AlbumsController < ApplicationController
  before_action :find_album, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    if logged_in_as_admin?
      @albums = Album.page(params[:page]).per(9)   
    else
      @albums = Album.where("seeable = ?", true).page(params[:page]).per(9)          
    end        
  end

  def select
    @album = Album.new    
  end

  def redirect
    redirect_to new_upload_photo_path(album_id: params[:album][:id])  
  end

  def show
    @photos = @album.upload_photos
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to select_albums_path(select_album: @album.id)
    else
      flash[:alert] = "標題請勿重複或是空白！"
      redirect_to :back
    end
  end

  def edit
    @photos = @album.upload_photos
  end

  def edit_all
    @albums = Album.all.where("title != ?", "預設相簿")
  end

  def update
    @album.title = params[:title]
    if @album.save
      flash[:notice] = "完成修改相簿"      
      redirect_to album_path(@album)
    else
      flash[:alert] = "標題請勿重複或是空白！"
      @photos = @album.upload_photos
      render :edit
    end
  end

  def destroy
    @album.destroy
    flash[:notice] = "您已刪除相簿"           
    redirect_back_or_to albums_path
  end

  def modify_seeable
    @album = Album.find(params[:album])   
    if @album.seeable 
      @album.update(seeable: false)
    else
      @album.update(seeable: true)
    end      
    redirect_back_or_to root_path
  end

  private

  def album_params
    params.require(:album).permit(:title)
  end

  def find_album
    @album = Album.find_by_slug(params[:id])
  end


end
