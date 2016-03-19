class UploadPhotosController < ApplicationController
  before_action :find_upload_photo, only: [:destroy]
  before_action :require_admin

  def index
    @upload_photos = UploadPhoto.all    
  end

  def new
    @upload_photo = UploadPhoto.new
    @album = Album.find(params[:album_id])
  end

  def create
    params[:upload_photo][:file].each do |file|
      @upload_photo = UploadPhoto.new
      @upload_photo.file = file
      @upload_photo.album_id = params[:upload_photo][:album_id]      
    end    
    
    respond_to do |format|
      if @upload_photo.save
        format.html { redirect_to @upload_photo, notice: 'Upload photo was successfully created.' }
        format.json { render json: {files: [@upload_photo.to_jq_upload]}, status: :created, location: @upload }
      else
        format.html { render action: 'new' }
        format.json { render json: @upload_photo.errors, status: :unprocessable_entity }
      end
    end    
  end

  def destroy
    if @upload_photo
      @upload_photo.destroy
    end
    respond_to do |format|    
      format.html { redirect_to :back } 
      format.js   { render json: {files: [@upload_photo.to_jq_upload]}, status: :created, location: @upload }        
    end        
  end

  private
  
  def find_upload_photo
    @upload_photo = UploadPhoto.find_by_id(params[:id])
  end  
end
