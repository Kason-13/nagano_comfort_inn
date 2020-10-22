module RoomDisplayHelper
  def display_availability(availability_in_bool)
    availability_str = "The room is currently "
    if availability_in_bool
      availability_str + "available"
    else
      availability_str + "unavailable or already reserved"
    end
  end
end
