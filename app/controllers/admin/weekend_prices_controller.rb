require 'pry'
class Admin::WeekendPricesController < Admin::BaseController
  before_filter :admin_only_action
  def edit
    @weekend_price = WeekendPrice.first
  end

  def update
    if(WeekendPrice.first.update_attributes(params[:weekend_price]))
      flash[:success] = "New weekend top up price saved!"
      redirect_to admin_price_modifiers_path
    else
      render 'edit'
    end
  end

end
