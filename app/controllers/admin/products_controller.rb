module Admin
    class ProductsController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_admin
  
      def index
        @products = Product.page(params[:page]).per(10)
        render 'admin/products/index'
      end
    
      def show
        @product = Product.find(params[:id])
        render 'products/show'
      end
  
      def new
        @product = Product.new
        render 'admin/products/new'
      end
  
      def create
        @product = Product.new(product_params)
        if @product.save
          redirect_to admin_products_path, notice: 'Product created successfully.'
        else
          render 'admin/products/new'
        end
      end
  
      def edit
        @product = Product.find(params[:id])
        render 'admin/products/edit'
      end
  
      def update
        @product = Product.find(params[:id])

        if params[:remove_image] == "1"
          @product.image.purge
        end

        if @product.update(product_params)
          redirect_to admin_products_path, notice: 'Product updated successfully.'
        else
          render 'admin/products/edit'
        end
      end
  
      def destroy
        @product = Product.find(params[:id])
        
        # Delete associated cart_items
        @product.cart_items.destroy_all
    
        # Now delete the product
        @product.destroy
    
        redirect_to admin_products_path, notice: "Product was successfully deleted."
      end
  
      private
  
      def product_params
        params.require(:product).permit(:name, :description, :price, :category_id, :image)
      end
  
      def authorize_admin
        redirect_to root_path, alert: 'Access denied' unless current_user&.admin?
      end
    end
  end
  