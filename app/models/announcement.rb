class Announcement < ActiveRecord::Base
  validates :title, :body, presence: true   
end
