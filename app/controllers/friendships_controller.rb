class FriendshipsController < ApplicationController

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
  	@friendship = Friendship.find params[:id]
  	flash[:notice] = "Amistad desechada" if @friendship.destroy
    redirect_to visitors_path
  end
end
