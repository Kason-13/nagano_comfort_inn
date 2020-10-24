require 'pry'
module SessionHelper

  def admin_mode
    session[:admin] = true
  end

  def is_admin?
    !session[:admin].nil?
  end

  def admin_only_action
    unless is_admin?
      redirect_to_home
    end
  end

  def redirect_to_home
    redirect_to root_path
  end
end
