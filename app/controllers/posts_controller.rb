class PostsController < ApplicationController

  before_action :nonlogin_access,{except: [:destroy2]}
  before_action :access_not,{only: [:edit, :update, :destroy]}

  def index
    @posts = Post.all.order(updated_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content],user_id: @current_user.id)
    if @post.save
      flash[:notice] = "投稿完了"
      redirect_to("/posts/index")
    else
      render("/posts/new")
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
    @comment = Comment.where(post_id: @post.id)
    @comment_count = Comment.where(post_id: @post.id).count
    @com = Comment.find_by(post_id: @post.id)
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @comment = Comment.where(post_id: params[:id])
    @like = Like.where(post_id: params[:id])
    @post.destroy
    if @comment
      @comment.destroy_all
    end
    if @like
      @like.destroy_all
    end
    redirect_to("/posts/index")
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      redirect_to("/posts/index")
    else
      redirect_to("/posts/#{@post.id}/edit")
    end
  end

  def comment
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end

  def access_not
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
