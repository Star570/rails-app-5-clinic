class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessor :be_admin
  default_scope {order('admin DESC, created_at DESC')}

  has_many :posts, dependent: :destroy
  has_many :announcements, dependent: :destroy  
  has_many :messages, dependent: :destroy    
  has_many :comments, dependent: :destroy      
  has_many :reservations, dependent: :destroy        

  has_secure_password
  # 要使用信箱, 手機, 市話都可以登入, 就一定要uniqueness

  validates :name,     presence: true, length: {minimum: 2, maximum: 4}
  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :password_confirmation, presence: true, on: :create, length: {minimum: 5}
  validates :email, uniqueness: true, :allow_blank => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }  

  validates :phone, uniqueness: true, :allow_blank => true, numericality: true, length: { minimum: 10, maximum: 10 }   
  validates :home_pre, :allow_blank => true, numericality: true    
  validates :home_post, uniqueness: true, :allow_blank => true, numericality: true, length: { minimum: 6, maximum: 8 }     
  validates_each :phone do |record, attr, value|
    record.errors.add(attr, '此非手機號碼') if value != "" && (value[0] != "0" || value[1] != "9")
  end

  # def twilio_client
  #   Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  # end

  def generate_pin       
    update(verified: false)         
    self.pin = rand(0000..9999).to_s.rjust(4, "0")
    save  
  end

  # def send_pin
  #   twilio_number = "+886" + phone[1..9]

  #   twilio_client.messages.create( 
  #     #to: twilio_number, 
  #     to: "+886916770589", 
  #     from: ENV['TWILIO_PHONE_NUMBER'], 
  #     body: "歡迎使用CY診所驗證系統, 請在網頁填入簡訊驗證碼#{pin}. 註冊人是#{name}, 註冊手機是#{phone}" 
  #   )       
  # end

  def send_pin
    UserMailer.notify_pin(self).deliver_now
  end  

  def verify_pin(entered_pin) 
    update(verified: true) if self.pin == entered_pin 
  end

  def home_phone
    if self.home_post && self.home_post != ""
      self.home_pre + "-" + self.home_post
    else
      ""
    end
  end

  def show_any_phone

    if self.phone && self.phone != ""
      self.phone[0..3] + "-" + self.phone[4..6] + "-" + self.phone[7..9]   
    elsif self.home_post && self.home_post != ""
      self.home_pre + "-" + self.home_post
    else
      ""
    end
  end


  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end  

  def resolve_friendly_id_conflict(candidates)
      same_slug = User.where("slug like '#{name}-%'")
      max_sequence = 0
      same_slug.each do |s|
        if s.slug.split("-").last.to_i > max_sequence
          max_sequence = s.slug.split("-").last.to_i
        end
      end
      max_sequence += 1
      candidates.first + friendly_id_config.sequence_separator + max_sequence.to_s
  end    

end
