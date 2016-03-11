class AddSeeableToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :seeable, :boolean, default: false        
  end
end
