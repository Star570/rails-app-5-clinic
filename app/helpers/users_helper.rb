module UsersHelper
  def num_of_reservation(user)
    user.reservations.count
  end

  def num_to_be_served(user)
    user.reservations.to_be_served.count    
  end

end
