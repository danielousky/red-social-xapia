class ApplicationController < ActionController::Base

  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User)
          '/visitors/dashboard'
      else
        super
      end
  end

end
