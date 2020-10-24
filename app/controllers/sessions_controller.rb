class SessionsController < ApplicationController
  def new
  end

  def create
    client = Client.find_by_email[params[:login][:email]] #email from login form
    if(client && client.authenticate(params[:login][:password]))
      sign_in(client)
      redirect_back_or(root_path)
    else
      flash.now[:error] = "invalid email or password"
      render 'new' #render back the form for login
    end
  end
end
