require 'pry'
class StaticPagesController < ApplicationController
  before_filter :admin_only_action
  def home
    @room_types = RoomType.all
    @view_types = ViewType.all
  end

  def admin
    admin_mode
    redirect_to_home
  end

  def admin_pannel
  end

  def exit_admin
    logoff_admin
    redirect_to_home
  end

  def help
  end

end
