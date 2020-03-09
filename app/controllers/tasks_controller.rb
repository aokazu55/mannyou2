class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 5

  def index
    if logged_in?
      @tasks = Task.page(params[:page]).per(PER).where(user_id: current_user.id)
    else
      redirect_to sessions_new_path
    end

      if params[:sort_deadline]
        @tasks = Task.all.order(deadline: :asc).page(params[:page]).per(PER).where(user_id: current_user.id)
      end

      if params[:sort_priority]
        @tasks = Task.all.order(priority: :desc).page(params[:page]).per(PER).where(user_id: current_user.id)
      end

      if params[:task] && params[:task][:search]

        if params[:task][:title].present? && params[:task][:status].present?
          @tasks = Task.title_search(params[:task][:title]).status_search(params[:task][:status]).page(params[:page]).per(PER).where(user_id: current_user.id)

        elsif params[:task][:title].empty? && params[:task][:status].present?
          @tasks = Task.status_search(params[:task][:status]).page(params[:page]).per(PER).where(user_id: current_user.id)

        elsif params[:task][:title].present? && params[:task][:status] == ""
          @tasks = Task.title_search(params[:task][:title]).page(params[:page]).per(PER).where(user_id: current_user.id)
        end
      end

  end

  def show
  end

  def new
    if logged_in? && params[:back]
      @task = Task.new(task_params)
    elsif logged_in?
      @task = Task.new
    else
      redirect_to new_session_path
    end
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to task_path(@task.id), notice: 'Task was successfully created.'
      else
        render :new
      end
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    if logged_in?
      @task = Task.find(params[:id])
    else
      redirect_to new_session_path
    end
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :priority, :status, :user_id)
  end
end
