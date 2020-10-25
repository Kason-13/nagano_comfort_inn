require 'pry'
class Admin::ViewTypesController < Admin::BaseController
  before_filter :admin_only_action, only: [:index,:new,:create,:destroy,:edit]
  def new
    @view_type = ViewType.new
  end

  def create
    @view_type = ViewType.new(params[:view_type])
    if(@view_type.save)
      flash[:success] = "View type has been saved into the available choices"
    end
    redirect_to admin_view_types_path
  end

  def edit
    @view_type = ViewType.find_by_id(params[:id])
  end

  def update
    if(ViewType.find_by_id(params[:id]).update_attributes(params[:view_type]))
      flash[:success] = "Updated informations for the view type"
      redirect_to admin_view_types_path
    else
      render 'edit'
    end
  end

  def delete
  end

  def destroy
  end

  def index
    @view_types = ViewType.paginate(page: params[:page])
  end

end
