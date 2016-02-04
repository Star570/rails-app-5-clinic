class Message < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :name, :title, :body, presence: true     
  validates :name, length: { maximum: 10 }
end
