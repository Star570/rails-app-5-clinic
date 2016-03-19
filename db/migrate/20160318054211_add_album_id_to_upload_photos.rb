class AddAlbumIdToUploadPhotos < ActiveRecord::Migration
  def change
    add_column :upload_photos, :album_id, :integer
    add_index  :upload_photos, :album_id         
  end
end
