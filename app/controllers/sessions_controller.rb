class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.verified
      session[:user_id] = user.id
      flash[:notice] = "歡迎#{user.name}登入！"
      redirect_to root_path
    elsif user && user.authenticate(params[:password])
      flash[:alert] = "您尚未通過電郵認證, 請重新註冊！"
      redirect_to register_path   
    else
      flash[:alert] = "您的電郵或密碼有誤！請重新登入！"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "已登出！"
    redirect_to root_path
  end

end