class LikesController < ApplicationController

  def create_user_show
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    @post = Post.find_by(id: params[:post_id])
    redirect_to("/users/#{@post.user_id}")
  end

  def destroy_user_show
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    @post = Post.find_by(id: params[:post_id])
    redirect_to("/users/#{@post.user_id}")
  end

  def create_index
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    redirect_to("/posts/index")
  end

  def destroy_index
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_to("/posts/index")
  end

  def create_post_show
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    redirect_to("/posts/#{params[:post_id]}")
  end

  def destroy_post_show
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_to("/posts/#{params[:post_id]}")
  end

end
