class ApplicationController < ActionController::Base
  include DaoHelper
  include RoomHelper
  include SessionHelper
  protect_from_forgery
end
