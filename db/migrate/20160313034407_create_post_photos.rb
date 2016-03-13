class CreatePostPhotos < ActiveRecord::Migration
  def change
    create_table :post_photos do |t|
      t.string :image

      t.timestamps null: false
    end
  end
end
