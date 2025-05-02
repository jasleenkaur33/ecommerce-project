module Admin
    class OrdersController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_admin
  
      def index
        @orders = Order.all
        render 'admin/orders/index'
      end
  
      def show
        @order = Order.find(params[:id])
        render 'admin/orders/show'
      end
  
      def update
        @order = Order.find(params[:id])
        if @order.update(order_params)
          redirect_to admin_orders_path, notice: 'Order status updated.'
        else
          render 'admin/orders/show'
        end
      end
  
      private
  
      def order_params
        params.require(:order).permit(:status)
        
      end
  
      def authorize_admin
        redirect_to root_path, alert: 'Access denied' unless current_user&.admin?
      end

      
    end
  end
  