class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:show]

  def show
    @posts = Post.all
    @categories = Category.all
  end

  def new
    @post = Post.new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @post = Post.create(post_params)
    @post.user = current_user    
    if @post.save
      flash[:notice] = "您已發佈一篇新專欄"      
      redirect_to categories_path
    else 
      render :new
    end
  end

  def edit
    @category = Category.new    
    @categories = Category.all    
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "您已修改專欄"           
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "您已刪除專欄"       
    redirect_to categories_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end
  
end
