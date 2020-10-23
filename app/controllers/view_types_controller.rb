class ViewTypesController < ApplicationController

  def new
    @view_type = ViewType.new
  end

  def create
    @view_type = ViewType.new(params[:room_type])
    if(@view_type.save)
      flash[:success] = "View type has been saved into the available choices"
    end
    redirect_to view_types_path
  end
end
