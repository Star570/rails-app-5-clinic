class UsersController < ApplicationController
  # rescue_from Twilio::REST::RequestError, with: :phone_number_error
  before_action :find_user, only: [:edit, :update, :destroy, :enter_pin, :finish_register]
  before_action :require_user_or_admin, only: [:edit, :update]
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
    find_user = User.find_by(email: user_params[:email])
    if find_user
      find_user.admin = (user_params[:be_admin] == "1") ? true : false
      if find_user.update(user_params)
        find_user.generate_pin   
        find_user.send_pin  
        flash[:notice] = "提示：已經發送認證碼至您的電子郵箱#{find_user.pin}"
        redirect_to enter_pin_user_path(find_user)    
      else
        render :new
      end
    else
      @user = User.new(user_params)
      @user.admin = (user_params[:be_admin] == "1") ? true : false
      if @user.save
        @user.generate_pin   
        @user.send_pin  
        flash[:notice] = "提示：已經發送認證碼至您的電子郵箱#{@user.pin}"        
        redirect_to enter_pin_user_path(@user)    
      else
        render :new
      end
    end      
  end

  def edit    
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "您已修改會員資料"    
      if (logged_in_as_admin? && current_user.id.to_s != params[:id])
        redirect_to backstage_user_show_path(user_id: params[:id])        
      else
        redirect_to user_path(current_user)
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
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :be_admin, :pin)
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
