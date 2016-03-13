class AnnouncementPhotosController < ApplicationController
  before_action :require_admin

  def upload
      @photo = AnnouncementPhoto.new
      @photo.image = params[:upload_file]
      success = true
      msg = '上傳成功'
      file_path = ''
      if @photo.save
        p "photo save成功"
        p @photo.image.url          
        success=true     
        render json: { :success=> success, :msg=>msg, :file_path=> @photo.image.url }
      else
        p "photo save失敗"
        p @photo.image.url            
        success=false
        render json: { :success=> false }
      end
  end    
end
