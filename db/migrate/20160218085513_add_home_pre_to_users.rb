class AddHomePreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_pre, :string    
    add_column :users, :home_post, :string        
  end
end
