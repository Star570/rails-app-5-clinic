class Announcement < ActiveRecord::Base
  default_scope {order('created_at DESC')}  
  belongs_to :user      
  validates :title, :body, presence: true   
end
