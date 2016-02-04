class ModifyPhoneDataTypeReservations < ActiveRecord::Migration
  def change
    change_column :reservations, :phone, :string    
  end
end
