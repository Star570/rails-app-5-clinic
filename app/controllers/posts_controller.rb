class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:show]

  def show
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

      # update photos id 
      array = @post.body.split('post/photos/').map{|x| x[0..27]}
      array.delete_at(0)
      array.each do |name|
        post_photo = PostPhoto.find_by(image: name)
        post_photo.post_id = @post.id
        post_photo.save
      end

      PostPhoto.select{|x| x.post_id == nil}.each do |photo|
        photo.destroy
      end
      
      redirect_to categories_path
    else 
      @category = Category.new
      @categories = Category.all      
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

      # update photos id 
      @post.post_photos.each do |p|
        p.post_id = nil
        p.save
      end

      array = @post.body.split('post/photos/').map{|x| x[0..27]}
      array.delete_at(0)
      array.each do |name|
        post_photo = PostPhoto.find_by(image: name)
        post_photo.post_id = @post.id
        post_photo.save
      end

      PostPhoto.select{|x| x.post_id == nil}.each do |photo|
        photo.destroy
      end

      redirect_to post_path(@post)
    else
      @category = Category.new
      @categories = Category.all                   
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "您已刪除專欄"       
    redirect_to categories_path
  end

  def modify_seeable
    @post = Post.find(params[:post])   
    if @post.seeable 
      @post.update(seeable: false)
    else
      @post.update(seeable: true)
    end      
    redirect_back_or_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end
  
end
