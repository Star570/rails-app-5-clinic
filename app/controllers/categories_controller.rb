class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]
  
  def index
    if logged_in_as_admin?
      @posts = Post.page(params[:page]).per(10) 
    else
      @posts = Post.where("seeable = ?", true).page(params[:page]).per(10)               
    end    
  end

  def show
    if logged_in_as_admin?
      @posts = @category.posts.page(params[:page]).per(10) 
    else
      @posts = @category.posts.where("seeable = ?", true).page(params[:page]).per(10)              
    end            
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to (:back)
    else
      flash[:alert] = "請填寫正確標題！"      
      redirect_to (:back)      
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
    redirect_to categories_path
  end
    
  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)  
  end  
    
end
