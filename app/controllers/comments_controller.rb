class CommentsController < ApplicationController

  def create
    @comment = Comment.new(user_id: @current_user.id,
                           post_id: params[:post_id],
                           comment: params[:comment])
    @comment.save
    redirect_to("/posts/#{params[:post_id]}")
  end

  def show
    @comment = Comment.find_by(id: params[:id])
    @user = User.find_by(id: @comment.user_id)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @user = User.find_by(id: @comment.user_id)
    @comment.destroy
    redirect_to("/users/#{@user.id}/comment")
  end

end
