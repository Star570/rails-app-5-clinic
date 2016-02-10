class AddUserIdToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :user_id, :integer
    add_index  :announcements, :user_id        
  end
end
