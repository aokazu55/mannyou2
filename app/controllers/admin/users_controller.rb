class Admin::UsersController < ApplicationController
  before_action :ensure_current_user_admin
  before_action :set_users, only: [:show, :destroy, :edit, :update]
  before_action :before_destroy, only: [:destroy]

  def index
    @users = User.all.includes(:tasks).order(id: "ASC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
       redirect_to tasks_path
       flash[:info] = "#{@user.name}さんのアカウントを作成しました"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
    flash[:success] = 'アカウントを削除しました'
  end

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    if User.where(admin: :true).count == 0
      @user.update(admin: :true)
      redirect_to admin_users_path
      flash[:warning] = "ユーザー【 #{@user.name} 】の権限以外を更新しました　※管理者は最低一人必要です"
    elsif @user.save == false
      flash[:danger] = "ユーザー情報の更新が出来ませんでした"
      render :edit
    elsif User.where(admin: :true).count >= 1
      redirect_to admin_users_path
      flash[:info] = "ユーザー【 #{@user.name} 】の更新をしました"
    end
  end

  private

  def ensure_current_user_admin
    if logged_in? == false
      redirect_to new_session_path
      flash[:danger] = "ログインしてください"
    elsif current_user.admin? == false
      redirect_to tasks_path
      flash[:danger] = "管理者権限がありません"
    end
  end

  def before_destroy
    if @user.admin == true && @user == current_user
      redirect_to admin_users_path
      flash[:danger] = "管理者自身は削除できません"
    end
  end
end
