class UserMailer < ApplicationMailer
  helper :application
  default :from => "postmaster@appa32cc29efd5643dab9aa2838491cce89.mailgun.org"

  def notify_pin(user)
    @user = user
    mail(:to => @user.email, 
         :subject => "歡迎到[CY診所]註冊")
  end  

  def notify_add_reservation(user, reservation)
    @user = user
    @reservation = reservation
    mail(:to => @user.email, 
         :subject => "[CY診所] 您的預約記錄")
  end  

  def notify_cancel_reservation(user, reservation)
    @user = user
    @reservation = reservation
    mail(:to => @user.email, 
         :subject => "[CY診所] 您的預約記錄已取消")
  end  

end
