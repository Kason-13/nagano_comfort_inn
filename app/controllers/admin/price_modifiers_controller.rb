require 'pry'
class Admin::PriceModifiersController < Admin::BaseController
  before_filter :admin_only_action
  def index
    @price_modifiers = PriceModifier.paginate(page:params[:page])
    if(WeekendPrice.first.nil?)
      WeekendPrice.create :price => '0.00'
    end
    @weekend_price = WeekendPrice.first
  end

  def new
    @price_modifier = PriceModifier.new
  end

  def create
    if(params[:from_date].empty? || params[:to_date].empty?)
      flash.now[:error] = "DATES CANNOT BE EMPTY"
      @price_modifier = PriceModifier.new
      return render 'new'
    end

    from_date = Date.parse(params[:from_date])
    to_date = Date.parse(params[:to_date])

    @price_modifier = PriceModifier.new(name:params[:price_modifier]["name"],
                                        price:params[:price_modifier]["price"],
                                        from_date:params[:from_date],
                                        to_date:params[:to_date])

    if(@price_modifier.save)
      (from_date..to_date).each do |day|
        add_modifier_date(day,@price_modifier.id)
      end
      flash[:success] = "Price modifier created"
      redirect_to admin_price_modifiers_path
    else
      render 'new'
    end
  end

  def update
    if(PriceModifier.find_by_id(params[:id]).update_attributes(params[:price_modifier]))
      flash[:success] = "Price has been modified"
      redirect_to admin_price_modifiers_path
    else
      @price_modifier = PriceModifier.find_by_id(params[:id])
      flash.now[:error] = "invalid infos for modification"
      render 'edit'
    end
  end

  def edit
    @price_modifier = PriceModifier.find_by_id(params[:id])
  end

  def destroy
    PriceModifier.find(params[:id]).destroy
    flash[:success] = "Removed price modifier"
    redirect_to admin_price_modifiers_path
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
