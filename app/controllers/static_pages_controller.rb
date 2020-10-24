require 'pry'
class StaticPagesController < ApplicationController

  def home
    @room_types_hashmap = hashmap_of_view_room_type_ls(create_roomType_list)
    @view_types_hashmap = hashmap_of_view_room_type_ls(create_viewType_list)
  end

  def admin
    admin_mode
    redirect_to_home
  end

  def help
  end

end
