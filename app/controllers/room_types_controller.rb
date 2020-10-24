class RoomTypesController < ApplicationController
  before_filter :admin_only_action, only: [:index,:new,:create,:destroy,:edit]

  def create
    @room_type = RoomType.new(params[:room_type])
    if(@room_type.save)
      flash[:success] = "Room type has been saved into the available choices"
    end
    redirect_to room_types_path
  end

  def index
    @room_types = RoomType.paginate(page: params[:page])
  end

  def new
    @room_type = RoomType.new
  end

  def destroy
  end

end
