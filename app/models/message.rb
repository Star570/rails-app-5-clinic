class Message < ActiveRecord::Base
  default_scope {order('created_at DESC')}  
  belongs_to :user      
  has_many :comments, dependent: :destroy
  validates :title, :body, presence: true   
end
