class Category < ActiveRecord::Base
  default_scope {order('created_at ASC')}
  has_many :posts, dependent: :destroy
  validates :name, presence: true, length: { maximum: 10 }
end
