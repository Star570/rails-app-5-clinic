class AddSeeableToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :seeable, :boolean, default: false        
  end
end
