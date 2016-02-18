class UsersController < ApplicationController
  # rescue_from Twilio::REST::RequestError, with: :phone_number_error
  before_action :find_user, only: [:edit, :update, :destroy, :enter_pin, :finish_register, :change_password, :change_password_verify]
  before_action :require_user_or_admin, only: [:edit, :update, :change_password, :change_password_verify]
  before_action :require_admin, only: [:destroy]  


  def show
    if (current_user && current_user.id.to_s == params[:id])
      @user = User.find(params[:id])
    else
      flash[:alert] = "必須是會員本人！"
      redirect_to root_path
    end
  end

  def new
    @user = User.new    
  end

  def create
    @user = User.new(user_params)
    @user.admin = (user_params[:be_admin] == "1") ? true : false
    @user.home_pre = params["home_pre"]
    @user.home_post = params["home_post"]     
    find_home_exist = User.find_by(home_post: params["home_post"])

    if find_home_exist
      flash[:alert] = "市話已經存在."        
      render :new     
    elsif @user.save
      @user.generate_pin   
      @user.send_pin  
      flash[:notice] = "提示：已經發送認證碼至您的電子郵箱#{@user.pin}"        
      redirect_to enter_pin_user_path(@user)    
    else
      render :new
    end         
  end

  def edit    
  end

  def update
    @user.home_pre = params["home_pre"]
    @user.home_post = params["home_post"]    
    find_home_exist = @user.home_post != params["home_post"] && User.find_by(home_post: params["home_post"])

    if @user.phone == "" && @user.email == "" && @user.home_post == ""
      flash[:alert] = "Email與手機或市話不可全部空白."        
      render :edit         
    elsif find_home_exist
      flash[:alert] = "市話已經存在."        
      render :edit         
    elsif @user.update(user_params)
      flash[:notice] = "您已修改會員資料"    
      if (logged_in_as_admin?)
        redirect_to backstage_user_show_path(user: @user)        
      else
        redirect_to user_path(@user)
      end
    else
      render :edit
    end    
  end

  def destroy
    flash[:notice] = "您已刪除#{@user.name}"          
    @user.destroy
    redirect_back_or_to root_path   
  end

  def change_password
    
  end

  def change_password_verify
    if ((@user.authenticate(params[:old_password]) || current_user.admin) && (params[:password] == params[:password_confirmation]))
      @user.update(update_user_password)
      flash[:notice] = "#{@user.name}的密碼已經更新"    
      if current_user.admin
        redirect_to backstage_user_show_path(user: @user)
      else
        redirect_to user_path(@user) 
      end
    elsif (params[:password] != params[:password_confirmation])
      flash[:alert] = "新密碼兩次輸入不同!"
      render :change_password
    else
      flash[:alert] = "舊密碼輸入錯誤!"
      render :change_password
    end
  end

  def enter_pin
  end

  def verify_pin
    @user = User.find_by(phone: params[:hidden_phone_number]) 
    @user.verify_pin(params[:pin]) 

    if @user.verified
      session[:user_id] = @user.id
    end
    redirect_to finish_register_user_path(@user)
  end

  def finish_register
    if @user && @user.verified
      flash[:notice] = "恭喜你註冊完成!"
    else
      flash[:alert] = "驗證碼錯誤, 請重新註冊!"
    end 
  end  

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :be_admin, :pin, :verified)
  end

  def update_user_password
    params.permit(:password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end

  # def phone_number_error    
  #   flash[:alert] = "目前只支援寄送簡訊到CY手機!"
  #   p "There has something Twilio error"
  #   redirect_to :back
  # end

end
