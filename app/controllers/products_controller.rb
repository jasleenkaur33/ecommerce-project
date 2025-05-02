class ProductsController < ApplicationController
  def index
    # Fetch categories for filtering
    @categories = Category.all

    # Fetch products with pagination
    @products = Product.page(params[:page]).per(10)

    # Apply filters based on params
    case params[:filter]
    when "on_sale"
      @products = @products.on_sale
    when "new"
      @products = @products.new_products
    when "recently_updated"
      @products = @products.recently_updated
    end
  end

  def show
    # Fetch product by ID
    @product = Product.find(params[:id])
  end

  def search
    # Fetch categories for dropdown
    @categories = Category.all

    # Search logic
    if params[:query].present?
      @products = Product.where("name ILIKE ? OR description ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
      @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
      @products = @products.page(params[:page]).per(10) # Add pagination to search results
    else
      @products = Product.none
    end
  end
end




# class ProductsController < ApplicationController
#     def index
#       # @products_top = Product.includes(:category).all
#       @products = Product.page(params[:page]).per(10)

 
#     end
  
#     def show
#       @product = Product.find(params[:id])
#     end

#     def search
#       @categories = Category.all
  
#       if params[:query].present?
#         @products = Product.where("name ILIKE ? OR description ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
#         @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
#       else
#         @products = Product.none
#       end
#     end

#   end


