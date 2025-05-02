class CartsController < ApplicationController
    def show
      @cart_items = @cart.cart_items.includes(:product)
    end
  
    def add_item
      product = Product.find(params[:product_id])
      cart_item = @cart.cart_items.find_or_initialize_by(product: product)

      cart_item.quantity = 0 if cart_item.quantity.nil?
      cart_item.quantity += params[:quantity].to_i
      cart_item.save
      redirect_to cart_path, notice: "#{product.name} added to cart."
    end
  
    def update_item
      cart_item = @cart.cart_items.find(params[:id])
      cart_item.update(quantity: params[:quantity])
      redirect_to cart_path, notice: "Cart updated successfully."
    end
  
    def remove_item
      cart_item = @cart.cart_items.find(params[:id])
      cart_item.destroy
      redirect_to cart_path, notice: "Item removed from cart."
    end
  end
  