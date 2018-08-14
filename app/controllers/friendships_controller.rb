# CONTROLADOR RELACIÓN DE AMISTAD ENTRE DOS USUARIOS.
class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:destroy,:confirmed]
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Amistad solicitada. Espere su confirmación."
    else
      flash[:notice] = "No se pudo realizar la solicitud de amistad: #{ @friendship.errors.full_messages.join}"
    end
    redirect_to visitors_path
  end

  def destroy
  	flash[:notice] = "Amistad desechada" if @friendship.destroy
    redirect_to visitors_path
  end


  def confirmed
    # FUNCION DE CONFIRMACIÓN DE RELACIÓN DE AMISTAD, OCURRE LUEGO DE UNA SOLICITUD
    reciprocal = Friendship.find_or_create_by(user_id: @friendship.friend_id, friend_id: @friendship.user_id)

    if @friendship.update(is_confirmed: true)
      reciprocal.update(is_confirmed: @friendship.is_confirmed) unless reciprocal.nil?
      flash[:notice] = "Amistad confirmada"
    else
      flash[:notice] = "No se pudo cambiar la amistad: #{@friendship.errors.full_messages.join}"
    end
    redirect_to visitors_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find params[:id]
    end

end
