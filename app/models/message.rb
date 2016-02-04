class Message < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :name, :title, :body, presence: true     
end
