class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_blog
    before_action :set_post, only: [:edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
  
    def create
      @post = @blog.posts.build(post_params)
      @post.user = current_user
      if @post.save
        redirect_to @blog, notice: 'Post was successfully created.'
      else
        render 'blogs/show'
      end
    end
  
    def edit
    end
  
    def update
      if @post.update(post_params)
        redirect_to @blog, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @post.destroy
      redirect_to @blog, notice: 'Post was successfully destroyed.'
    end
  
    private
  
    def set_blog
      @blog = Blog.find(params[:blog_id])
    end
  
    def set_post
      @post = @blog.posts.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:content)
    end
  
    def authorize_user!
      redirect_to @blog, alert: 'You are not authorized to perform this action.' unless @post.user == current_user || current_user.admin?
    end
  end
  