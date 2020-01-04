class PostsController < ApplicationController
  before_action :require_user!, except: %i[show]

  def show
    @post = Post.find_by(id: params[:id])
    @comments_by_parent_id = @post.comments_by_parent_id
    render :show
  end
  
  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params.merge(author_id: current_user.id))
    
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])
    post.destroy!
    redirect_to subs_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
