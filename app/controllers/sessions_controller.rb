require 'pry'
class SessionsController < ApplicationController
  def new
  end

  def create
    client = Client.find_by_email(params[:session][:email].downcase) #email from login form
    if(client && client.authenticate(params[:session][:password]))
      sign_in(client)
      redirect_back_or(root_path)
    else
      flash.now[:error] = "invalid email or password"
      render 'new' #render back the form for login
    end
  end

  def destroy
    sign_out
    redirect_back_or(root_path)
  end
end
