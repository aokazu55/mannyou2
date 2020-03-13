class LabelsController < ApplicationController
  before_action :set_label, only: [:edit, :update, :destroy]

  def index
    @labels = Label.where(user_id: current_user.id)
    @labels_default = Label.where(user_id: nil)
  end

  def new
    if logged_in?
      @label = Label.new
    else
      redirect_to new_session_path
    end
  end

  def create
    @label = Label.new(label_params)
    @label.user_id = current_user.id
    if @label.save
      redirect_to labels_path
      flash[:success] = "ラベルを作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path
      flash[:success] = "ラベルを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path
    flash[:sucess] = "ラベルを削除しました"
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:label_type, :user_id)
  end
end

# class LabelsController < ApplicationController
#   before_action :set_label, only: [:edit, :destroy]
#   before_action :label_params, only: [:edit, :destroy]
#
#   def new
#     @label = Label.new
#   end
#
#   def create
#     @label = current_user.labels.build(label_params)
#     if @label.save
#       flash[:success] ='ラベルを作成しました'
#       redirect_to new_label_path
#     else
#       flash[:danger] ="作成に失敗しました"
#       render 'new'
#     end
#   end
#
#   def edit
#   end
#
#   def update
#     if @label.update(label_params)
#       flash[:success] ='ラベルを更新しました'
#       redirect_to root_path
#     else
#       flash[:danger] ="更新に失敗しました"
#       render 'edit'
#     end
#   end
#
#   def destroy
#     @label.destroy
#     flash[:danger] ='ラベルを削除しました'
#     redirect_to root_path
#   end
#
#   private
#
#   def set_label
#     @label = Label.find(params[:id])
#   end
#
#   def label_params
#     params.require(:label).permit(:label_type)
#   end
#
# end
