class AddSeeableToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :seeable, :boolean, default: false    
  end
end
