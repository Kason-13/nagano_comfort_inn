class RoomsController < ApplicationController

  def show
    @room = Room.find(params[:id])
  end

  def index
  end

  def edit
  end

  def updated
  end

  def create

  end

  def new
    @room = Room.new
  end


  def destroy

  end
end
