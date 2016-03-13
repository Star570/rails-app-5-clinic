class AnnouncementPhotosController < ApplicationController
  before_action :require_admin

  def upload
      @photo = AnnouncementPhoto.new
      @photo.image = params[:upload_file]
      success = true
      msg = '上傳成功'
      file_path = ''
      
      if @photo.save         
        success=true     
        render json: { :success=> success, :msg=>msg, :file_path=> @photo.image.url }
      else     
        success=false
        render json: { :success=> false }
      end
  end    
end
