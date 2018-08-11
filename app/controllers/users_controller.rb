class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:keyworks]
      @users = User.search params[:keyworks]
    else
     @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, :alert => "Access denied."
    end
  end


end
