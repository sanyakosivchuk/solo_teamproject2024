class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post
  
    def create
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
      if @comment.save
        redirect_to @post.blog, notice: 'Comment was successfully created.'
      else
        redirect_to @post.blog, alert: 'Comment could not be created.'
      end
    end
  
    def destroy
      @comment = @post.comments.find(params[:id])
      if @comment.user == current_user || current_user.admin?
        @comment.destroy
        redirect_to @post.blog, notice: 'Comment was successfully deleted.'
      else
        redirect_to @post.blog, alert: 'You are not authorized to delete this comment.'
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  