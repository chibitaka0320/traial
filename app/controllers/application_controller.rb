class ApplicationController < ActionController::Base
  before_action :current_login

  def current_login
    @current_user = User.find_by(id: session[:user_id])
  end

  def nonlogin_access
     if @current_user == nil
       flash[:notice] = "ログインしてください"
       redirect_to("/login")
     end
   end

   def login_access
     if @current_user
       flash[:notice] = "すでにログインしています"
       redirect_to("/posts/index")
     end
   end
end
