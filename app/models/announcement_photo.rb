class AnnouncementPhoto < ActiveRecord::Base
 validates :image, presence: true
 mount_uploader :image, AnnouncementPhotoUploader  

 belongs_to :announcement  
end
