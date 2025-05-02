class OrdersController < ApplicationController
  before_action :authenticate_user!


  def index
    @orders = current_user.orders
  end
  

  def new
    @order = Order.new
    @cart_items = current_user.cart.cart_items
    @order_total = calculate_order_total
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
  

  def create
    address = find_or_create_address

    return redirect_to cart_path, alert: "Failed to save address." unless address

    @order = current_user.orders.new(address: address)
    @cart = current_user.cart

    # Create order items
    @cart.cart_items.each do |cart_item|
      @order.order_items.build(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )
    end

    # Save the order and charge the payment
    ApplicationRecord.transaction do
      if @order.save
        @cart.cart_items.destroy_all
        redirect_to order_path(@order), notice: "Order placed successfully."
      else
        raise ActiveRecord::Rollback
      end
    rescue ActiveRecord::Rollback
      redirect_to cart_path, alert: "Failed to place order."
    end
  end
 # Calculate the order total (this function should already be defined)
  def calculate_order_total
    @cart.cart_items.sum { |item| item.product.price * item.quantity }
  end
  private

  def order_params
    params.require(:order).permit(:address_id)
  end

  def address_params
    params.require(:order).require(:address).permit(:line1, :line2, :city, :province_id, :postal_code)
  end

  def find_or_create_address
    if params[:order][:address_id].present?
      address = current_user.addresses.find_by(id: params[:order][:address_id])
    else
      address = current_user.addresses.create(address_params)
    end
    address
  end

end
