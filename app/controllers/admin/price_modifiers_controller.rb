require 'pry'
class Admin::PriceModifiersController < Admin::BaseController
  before_filter :admin_only_action
  def index
    @price_modifiers = PriceModifier.paginate(page:params[:page])
    @weekend_price = WeekendPrice.first
  end

  def new
    @price_modifier = PriceModifier.new
  end

  def create
    from_date = Date.parse(params[:from_date])
    to_date = Date.parse(params[:to_date])

    @price_modifier = PriceModifier.new(params[:price_modifier])
    if(!@price_modifier.save!)
      render 'new'
    end

    (from_date..to_date).each do |day|
      add_modifier_date(day,@price_modifier.id)
    end
    redirect_to admin_price_modifiers_path
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def delete
  end

  private

  def add_modifier_date(day,modifier_id)
    if(ReservationDate.where(:date => day).blank?)
      new_reservation_date = ReservationDate.new(date:day)
      if(!new_reservation_date.save!)
        render 'new'
      end
    end
    found_date = ReservationDate.where(:date => day).first
    found_date.price_modifier_id = modifier_id
    found_date.save!
  end
end
