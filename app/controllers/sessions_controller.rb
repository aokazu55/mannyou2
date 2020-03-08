class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to tasks_path
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password_digest])
      session[:user_id] = user.id
      if current_user.admin?
        redirect_to admin_user_path(user.id)
        flash[:success] = 'ログインしました'
      else
        redirect_to user_path(user.id)
        flash[:success] = 'ログインしました'
      end
    else
      redirect_to new_session_path
      flash[:danger] = 'ログインに失敗しました'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
