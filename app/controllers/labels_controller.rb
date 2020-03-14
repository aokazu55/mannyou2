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
