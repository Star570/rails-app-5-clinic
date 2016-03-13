class CreateAnnouncementPhotos < ActiveRecord::Migration
  def change
    create_table :announcement_photos do |t|
      t.string :image
      t.timestamps null: false
    end
    add_column :announcement_photos,:announcement_id,:integer
    add_index :announcement_photos, :announcement_id    
  end
end
