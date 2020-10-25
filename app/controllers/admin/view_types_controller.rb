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

  def destroy
  end

  def index
    @view_types = ViewType.paginate(page: params[:page])
  end

end
