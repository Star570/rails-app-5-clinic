class SessionsController < ApplicationController
  def new
    
  end

  def create
    user_by_email = User.find_by(email: params[:email_or_phone])
    user_by_phone = User.find_by(phone: params[:email_or_phone])    
    if user_by_email && user_by_email.authenticate(params[:password]) && user_by_email.verified
      session[:user_id] = user_by_email.id
      flash[:notice] = "歡迎#{user_by_email.name}登入！"
      redirect_to root_path
    elsif user_by_phone && user_by_phone.authenticate(params[:password]) && user_by_phone.verified
      session[:user_id] = user_by_phone.id
      flash[:notice] = "歡迎#{user_by_phone.name}登入！"
      redirect_to root_path      
    elsif user_by_phone && user_by_phone.authenticate(params[:password]) && user_by_phone.email == "example@gmail.com"
      session[:user_id] = user_by_phone.id
      flash[:notice] = "歡迎#{user_by_phone.name}登入！"
      redirect_to root_path         
    elsif user_by_email && user_by_email.authenticate(params[:password])
      flash[:alert] = "您尚未通過電郵認證, 請重新註冊！"
      redirect_to register_path   
    else
      flash[:alert] = "您的電郵或手機或密碼有誤！請重新登入！"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "已登出！"
    redirect_to root_path
  end

end