class SessionsController < ApplicationController
  def new
    
  end

  def create
    user_by_email = User.find_by(email: params[:email_or_phone])
    user_by_phone = User.find_by(phone: params[:email_or_phone])    
    user_by_home_post_1 = User.find_by(home_post: params[:email_or_phone][2..11])
    user_by_home_post_2 = User.find_by(home_post: params[:email_or_phone][3..11])    
    if user_by_email && user_by_email.authenticate(params[:password]) && user_by_email.verified
      session[:user_id] = user_by_email.id
      flash[:notice] = "歡迎#{user_by_email.name}登入！"
      redirect_to root_path
    elsif user_by_phone && user_by_phone.authenticate(params[:password]) && user_by_phone.verified
      session[:user_id] = user_by_phone.id
      flash[:notice] = "歡迎#{user_by_phone.name}登入！"
      redirect_to root_path      
    elsif user_by_home_post_1 && user_by_home_post_1.home_pre == params[:email_or_phone][0..1] && 
          user_by_home_post_1.authenticate(params[:password]) && user_by_home_post_1.verified
      session[:user_id] = user_by_home_post_1.id
      flash[:notice] = "歡迎#{user_by_home_post_1.name}登入！"
      redirect_to root_path   
    elsif user_by_home_post_2 && user_by_home_post_2.home_pre == params[:email_or_phone][0..2] && 
          user_by_home_post_2.authenticate(params[:password]) && user_by_home_post_2.verified
      session[:user_id] = user_by_home_post_2.id
      flash[:notice] = "歡迎#{user_by_home_post_2.name}登入！"
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