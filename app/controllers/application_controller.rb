class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_cart
  helper_method :current_cart

  def current_cart
    if session[:cart_id].present?
      @current_cart = Cart.find(session[:cart_id])
    else
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
  end
end
