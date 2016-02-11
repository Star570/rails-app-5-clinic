class Post < ActiveRecord::Base
  default_scope {order('created_at DESC')}
  belongs_to :user      
  belongs_to :category
  validates :title, :body, presence: true   
end
