class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def show
    @categories = Category.all
  end

  def new
    @post = Post.new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to column_path
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
      redirect_to column_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to column_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end
  
end
