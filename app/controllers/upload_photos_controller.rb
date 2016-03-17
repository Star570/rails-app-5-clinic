class UploadPhotosController < ApplicationController
  before_action :find_upload_photo, only: [:destroy]

  def index
    @upload_photos = UploadPhoto.all    
  end

  def new
    @upload_photo = UploadPhoto.new
  end

  def create

    params[:upload_photo][:file].each do |file|
      @upload_photo = UploadPhoto.new
      @upload_photo.file = file
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
    @upload_photo.destroy
    redirect_to upload_photos_path  
  end

  private
  
  def find_upload_photo
    @upload_photo = UploadPhoto.find(params[:id])
  end  
end
