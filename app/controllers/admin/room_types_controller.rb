class Admin::RoomTypesController < Admin::BaseController
  before_filter :admin_only_action, only: [:index,:new,:create,:destroy,:edit]

  def create
    @room_type = RoomType.new(params[:room_type])
    if(@room_type.save)
      flash[:success] = "Room type has been saved into the available choices"
    end
    redirect_to admin_room_types_path
  end

  def index
    @room_types = RoomType.paginate(page: params[:page])
  end

  def new
    @room_type = RoomType.new
  end

  def edit
    @room_type = RoomType.find_by_id(params[:id])
  end

  def update
    if(RoomType.find_by_id(params[:id]).update_attributes(params[:room_type]))
      flash[:success] = "Updated informations for the view type"
      redirect_to admin_room_types_path
    else
      render 'edit'
    end
  end

  def delete
  end

  def destroy
  end

end
