module RoomHelper

  #method to create a list of all the room types from the DB
  def create_roomType_list
    #retrieve all room types
    room_type_options = RoomType.all
    # create lists of room types from that we retrieved from db
    room_types_ls = []
    room_type_options.each do |room_type|
      room_types_ls.push([room_type.room,room_type.id])
    end
    room_types_ls
  end

  #method to create a list of all the view types from the DB
  def create_viewType_list
    #retrieve all room types
    view_type_options = ViewType.all
    # create lists of view types from that we retrieved from db
    view_types_ls = []
    view_type_options.each do |view_type|
      view_types_ls.push([view_type.view,view_type.id])
    end
    view_types_ls
  end

  #creates a hashmap version of the view type list or room type list
  # in form id => type name
  def hashmap_of_view_room_type_ls(list)
    hashmap_of_ls = {}
    list.each do |item|
      hashmap_of_ls[item[1]] = item[0]
    end
    hashmap_of_ls
  end

end
