class ApplicationController < ActionController::Base

before_action :configure_permitted_parameters, if: :devise_controller?
before_action :categories, :brands, :items_in_cart

# helper_method :current_order

rescue_from CanCan::AccessDenied do |exception|
	respond_to do |format|
		format.html { redirect_to root_url, alert: exception.message }
	end
end

	def items_in_cart
	@line_items = current_order.line_items
	end

	def current_order
		if !session[:order_id].nil?
			Order.find(session[:order_id])
		else
			Order.new
		end
	end

	def categories
		@categories = Category.order(name: :asc)
	end

	def brands
		@brands = Product.pluck(:brand).uniq.sort
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name, :birthday, :address, :city, :zip, :state, :phone])
		devise_parameter_sanitizer.permit(:account_update, keys: [:role, :name, :birthday, :address, :city, :zip, :state, :phone])
	end
	
end
