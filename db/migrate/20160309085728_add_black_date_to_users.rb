class AddBlackDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :black_date, :date      
  end
end
