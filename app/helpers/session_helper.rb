require 'pry'
module SessionHelper

  #############################    user   ############################
  def sign_in(client)
    cookies.permanent[:remember_token] = client.remember_token
    self.current_client = client
  end

  def sign_out
    self.current_client = nil
    cookies.delete(:remember_token)
  end

  def current_client=(client)
    @current_client = client
  end

  def current_client
    @current_client ||= Client.find_by_remember_token(cookies[:remember_token])
  end

  def is_current_client?(client)
    client == current_client
  end

  def is_signed_in?
    !current_client.nil?
  end

  def signed_in_client
    unless is_signed_in?
      store_location
      redirect_to signin_path
    end
  end

 ############################ admin #########################

  def admin_mode
    session[:admin] = true
  end

  def logoff_admin
    session[:admin] = nil
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

  def redirect_back_or(route)
    redirect_to(session[:return_to] || route)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end


end
