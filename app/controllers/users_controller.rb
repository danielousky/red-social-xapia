class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where('id != ?', current_user.id)
    @users = @users.search params[:keywords] if params[:keywords] 
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, :alert => "Acceso denegado."
    end
  end

  private

    def user_params
      params.require(:admin_user).permit(:name, :email, :password, :password_confirmation)
    end
end
