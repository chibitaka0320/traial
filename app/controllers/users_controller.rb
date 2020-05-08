class UsersController < ApplicationController

  before_action :notlogin,{only: [:edit, :update]}
  before_action :nonlogin_access,{only: [:index, :show, :edit, :update, :destroy]}
  before_action :login_access,{only: [:login, :login_form, :new]}

  def index
    @users = User.all.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name],
                    password: params[:password],
                    image_name: "icons.jpg")
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/posts/index")
    else
      render("/users/new")
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @post = Post.where(user_id: params[:id])
    @like = Like.where(user_id: params[:id])
    @comment = Comment.where(user_id: params[:id])
    @user.destroy
    if @post
      @post.destroy_all
    end
    if @like
      @like.destroy_all
    end
    if @comment
      @comment.destroy_all
    end
    redirect_to("/signup")
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.password = params[:password]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      redirect_to("/users/#{@user.id}")
    else
      render("/users/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(name: params[:name], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to("/posts/index")
    else
      @error = "名前かパスワードが違います"
      @name = params[:name]
      @password = params[:password]
      render("/users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/login")
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id).order(updated_at: :desc)
  end

  def comment
    @user = User.find_by(id: params[:id])
    @comments = Comment.where(user_id: @user.id)
  end

  def notlogin
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
