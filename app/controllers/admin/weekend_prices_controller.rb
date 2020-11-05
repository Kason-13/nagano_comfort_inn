require 'pry'
class Admin::WeekendPricesController < Admin::BaseController
  before_filter :admin_only_action
  def edit
    create_price_if_nil
    @weekend_price = WeekendPrice.first
  end

  def update
    create_price_if_nil
    if(WeekendPrice.first.update_attributes(params[:weekend_price]))
      flash[:success] = "New weekend top up price saved!"
      redirect_to admin_price_modifiers_path
    else
      render 'edit'
    end
  end

  private
  def create_price_if_nil
    if(WeekendPrice.first.nil?)
      WeekendPrice.create :price => '0.00'
    end
  end

end
