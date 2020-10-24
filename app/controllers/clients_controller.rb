class ClientsController < ApplicationController
  def new
    @client = Client.new
  end
  def create
    @client = Client.new(params[:client])
    if(@client.save)
      flash[:success] = "You have successfuly registered"
      redirect_to_home
    else
      render 'new'
    end
  end
end
