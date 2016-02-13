class UserMailer < ApplicationMailer
  helper :application
  default :from => "postmaster@appa32cc29efd5643dab9aa2838491cce89.mailgun.org"

  def notify_pin(user)
    @user = user
    if check_email(@user.email)
      mail(:to => @user.email, 
           :subject => "歡迎到[CY診所]註冊")      
    end
  end  

  def notify_add_reservation(user, reservation)
    @user = user
    @reservation = reservation    
    if check_email(@user.email)    
      mail(:to => @user.email, 
           :subject => "[CY診所] 您的預約記錄")
    end
  end  

  def notify_cancel_reservation(user, reservation)
    @user = user
    @reservation = reservation    
    if check_email(@user.email)       
      mail(:to => @user.email, 
           :subject => "[CY診所] 您的預約記錄已取消")
    end
  end  

  def check_email(email)
    if (email == "example@gmail.com" || 
      !!email.match(/chen[0-9][0-9]@gmail.com/) || 
      !!email.match(/pan[0-9][0-9]@gmail.com/)  ||
      !!email.match(/chen[0-9][0-9][0-9]@gmail.com/) ||
      !!email.match(/pan[0-9][0-9][0-9]@gmail.com/))
      p "this is fake email, do not send out email"
      false
    else
      true
    end
  end

end
