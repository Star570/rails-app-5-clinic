class AddBlackToUsers < ActiveRecord::Migration
  def change
    add_column :users, :black, :boolean, default: false       
  end
end
