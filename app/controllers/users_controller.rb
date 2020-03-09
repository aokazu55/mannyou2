class UsersController < ApplicationController
  before_action :ensure_current_user, only: [:show]
  before_action :set_users, only: [:show]

  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
       session[:user_id] = @user.id
       redirect_to user_path(@user.id)
       flash[:info] = "#{@user.name}さんのアカウントを作成しました"
    else
      render :new
    end
  end

  def show
  end

  private

  def ensure_current_user
    if logged_in? == false
      redirect_to new_session_path
      flash[:danger] = "ログインしてください"
    elsif current_user.id != params[:id].to_i
      redirect_to tasks_path
    end
  end
end
