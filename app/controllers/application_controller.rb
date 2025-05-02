class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart


  protected

  # Allow additional Devise parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  # Set cart for user or session
  def set_cart
    if user_signed_in?
      @cart = current_user.cart || current_user.create_cart
    else
      @cart = Cart.find_or_create_by(id: session[:cart_id])
      session[:cart_id] = @cart.id
    end
  end
end
