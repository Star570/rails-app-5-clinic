class AddPostIdToPostPhotos < ActiveRecord::Migration
  def change
    add_column :post_photos, :post_id, :integer
    add_index  :post_photos, :post_id        
  end
end
