class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in_as_user?, :logged_in_as_admin?

  def redirect_back_or_to(*args)
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to *args
  rescue AbstractController::DoubleRenderError     
    
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    p "current_user not found in model"
    @current_user = nil
    session[:user_id] = nil  
    flash[:alert] = "請重新登入！"    
    redirect_to root_path
  end

  def logged_in?
    !!current_user
  end 

  def logged_in_as_user?
    current_user && current_user.admin == false
  rescue NoMethodError
    false
  end

  def logged_in_as_admin?
    current_user && current_user.admin == true
  rescue NoMethodError
    false    
  end

  def require_user
    if !logged_in_as_user?
      flash[:alert] = "必須登入會員！"
      redirect_back_or_to root_path  
    end
  end

  def require_admin
    if !logged_in_as_admin?
      flash[:alert] = "必須登入管理者！"
      redirect_back_or_to root_path      
    end
  end

  def require_user_or_admin
    if !logged_in_as_admin? && !logged_in_as_user?
      flash[:alert] = "必須登入會員或管理者！"
      redirect_back_or_to root_path      
    end
  end  

end
