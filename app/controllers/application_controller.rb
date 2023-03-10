class ApplicationController < ActionController::Base
  before_action :authenticate_account!, except: [:top, :about, :index, :show]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
