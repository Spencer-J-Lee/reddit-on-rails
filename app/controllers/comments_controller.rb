class CommentsController < ApplicationController
  before_action :require_user!

  def show
    @comment = Comment.find_by(id: params[:id])
    render :show
  end

  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to post_url(@comment.post)
    end
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:content, :post_id, :parent_comment_id)
      .merge(author_id: current_user.id)
  end
end
