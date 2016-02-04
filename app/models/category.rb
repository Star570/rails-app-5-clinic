class Category < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  validates :name, presence: true, length: { maximum: 10 }
end
