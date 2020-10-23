class RoomsController < ApplicationController

  def show
    @room = Room.find(params[:id])
  end

  def index
    @rooms = Room.paginate(page: params[:page])
  end

  def edit
  end

  def updated
  end

  def create
    @room = Room.new(params[:room])
    if(@room.save)
      redirect_to @room
    else
      render 'new'
    end
  end

  def new
    @room = Room.new
  end


  def destroy

  end
end
