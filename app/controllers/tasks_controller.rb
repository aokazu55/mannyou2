class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
PER = 6

  def index
    if params[:sort_deadline]
      @tasks = Task.all.order(deadline: :asc).page(params[:page]).per(6)
    end
    # deadlineのソート

    if params[:sort_priority]
      @tasks = Task.all.order(priority: :desc).page(params[:page]).per(6)
    end
    # priorityのソート

    if params[:task] && params[:task][:search]

      if params[:task][:title].present? && params[:task][:status].present?
        #タイトルもステータスもある場合
        @tasks = Task.title_search(params[:task][:title]).status_search(params[:task][:status]).page(params[:page]).per(6)

      elsif params[:task][:title].empty? && params[:task][:status].present?
        #タイトルが無く、ステータスはある場合
        @tasks = Task.status_search(params[:task][:status]).page(params[:page]).per(6)

      elsif params[:task][:title].present? && params[:task][:status] == ""
        #タイトルがあり、ステータスは無い場合
        @tasks = Task.title_search(params[:task][:title]).page(params[:page]).per(6)

      end
    end
  end


  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
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
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :priority, :status, :user_id)
    end


end
