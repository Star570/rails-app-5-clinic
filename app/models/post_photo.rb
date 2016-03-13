class PostPhoto < ActiveRecord::Base
 validates :image, presence: true
 mount_uploader :image, PostPhotoUploader  

 belongs_to :post
end
