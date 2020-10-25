class ApplicationController < ActionController::Base
  include SessionHelper
  protect_from_forgery
end
