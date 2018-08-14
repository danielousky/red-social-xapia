# ENTIDAD QUE CONTROLA EL PANEL INICIO O DASHBOARD DE LOS USUARIO
class VisitorsController < ApplicationController
  before_action :authenticate_user!


  def index
  	@user = current_user
  	@comment = Comment.new
  end

end
