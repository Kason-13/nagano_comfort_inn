class Admin::RoomsController < Admin::BaseController
  before_filter :admin_only_action, only: [:edit,:update,:destroy,:create,:new]

  def edit
    @room = Room.find_by_id(params[:id])
    @view_types_ls = create_viewType_list
    @room_types_ls = create_roomType_list
  end

  def update
    if(Room.find_by_id(params[:id]).update_attributes(params[:room]))
      flash[:success] = "Updated room listing"
      redirect_to rooms_path
    else
      flash.now[:error] = "Invalid informations, room number might be already taken"
      @room = Room.find_by_id(params[:id])
      @view_types_ls = create_viewType_list
      @room_types_ls = create_roomType_list
      render 'edit'
    end
  end

  def create
    @room = Room.new(params[:room])
    if(@room.save)
      flash[:success] = "Created new room"
      redirect_to rooms_path
    else
      @view_types_ls = create_viewType_list
      @room_types_ls = create_roomType_list
      render 'new'
    end
  end

  def new
    @room = Room.new
    @view_types_ls = create_viewType_list
    @room_types_ls = create_roomType_list
  end


  def destroy
    room_id = params[:id]
    room = Room.find_by_id(room_id)
    room.deleted = true
    room.save!
    redirect_to rooms_path
  end

  private
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

end
