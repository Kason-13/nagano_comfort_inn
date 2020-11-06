module DataReportHelper
  def display_occupied_rooms_numbers(rooms)
    unoccupied_rooms = []
    rooms.each do |room|
      unoccupied_rooms.push(room.room.room_num)
    end
    unoccupied_rooms.join(',')
  end
end
