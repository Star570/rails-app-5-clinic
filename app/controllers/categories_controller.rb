class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def show
    @posts = Post.all.order("created_at DESC")
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to (:back)
    else
      
    end
  end

  def edit
    @categories = Category.all  
  end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category)
    else
      render :edit
    end
  end  

  def destroy
    @category.destroy
    redirect_to column_path
  end
    
  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)  
  end  
    
end
