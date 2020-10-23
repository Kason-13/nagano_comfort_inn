class ApplicationController < ActionController::Base
  include DaoHelper
  include RoomHelper
  protect_from_forgery
end
