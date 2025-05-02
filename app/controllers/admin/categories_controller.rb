module Admin
    class CategoriesController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_admin
  
      def index
        @categories = Category.all
        render 'admin/categories/index'
      end
  
      def new
        @category = Category.new
        render 'admin/categories/new'
      end
  
      def create
        @category = Category.new(category_params)
        if @category.save
          redirect_to admin_categories_path, notice: 'Category created successfully.'
        else
          render 'admin/categories/new'
        end
      end
  
      def edit
        @category = Category.find(params[:id])
        render 'admin/categories/edit'
      end
  
      def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
          redirect_to admin_categories_path, notice: 'Category updated successfully.'
        else
          render 'admin/categories/edit'
        end
      end
  
      def destroy
        @category = Category.find(params[:id])
        @category.destroy
        redirect_to admin_categories_path, notice: 'Category deleted successfully.'
      end
  
      private
  
      def category_params
        params.require(:category).permit(:name)
      end
  
      def authorize_admin
        redirect_to root_path, alert: 'Access denied' unless current_user&.admin?
      end
    end
  end
  