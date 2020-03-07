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

# class UsersController < ApplicationController
#   before_action :set_user, only: [:show, :edit, :update, :destroy]
#
#   def index
#     @users = User.all
#   end
#
#   def show
#   end
#
#   def new
#     @user = User.new
#   end
#
#   def edit
#   end
#
#   def create
#     @user = User.new(user_params)
#
#     if @user.save
#       redirect_to @user, notice: 'User was successfully created.'
#     else
#       render :new
#     end
#   end
#
#   def update
#     if @user.update(user_params)
#       redirect_to @user, notice: 'User was successfully updated.'
#     else
#       render :edit
#     end
#   end
#
#   def destroy
#     @user.destroy
#     redirect_to users_url, notice: 'User was successfully destroyed.'
#   end
#
#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_user
#       @user = User.find(params[:id])
#     end
#
#     # Only allow a trusted parameter "white list" through.
#     def user_params
#       params.require(:user).permit(:name, :email, :password_digest, :password_confirmation)
#     end
# end
