class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @newest_blogs = Blog.order(created_at: :desc).limit(10)
    if params[:query].present?
      @blogs = Blog.search(params[:query], fields: [:title, :user_email, :category_name], match: :word_start)
    elsif params[:category_id].present?
      @category = Category.find(params[:category_id])
      @blogs = @category.blogs
    else
      @blogs = Blog.all
    end
  end

  def show
    @post = @blog.posts.build
    @posts = @blog.posts
  end

  def new
    @blog = current_user.blogs.build
    @categories = Category.all
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      @categories = Category.all
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_url, notice: 'Blog was successfully destroyed.'
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :photo, :category_id)
  end

  def authorize_user!
    redirect_to blogs_path, alert: 'You are not authorized to perform this action.' unless @blog.user == current_user || current_user.admin?
  end
end
