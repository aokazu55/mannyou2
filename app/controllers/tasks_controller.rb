class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
PER = 7

  def index
    if params[:sort_deadline]
      @tasks = Task.all.order(deadline: :asc).page(params[:page]).per(7)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :desc)
    elsif params[:title].blank? && params[:status].blank?
      @tasks = Task.all.page(params[:page])
    elsif params[:title].blank? && params[:status]
      @stauts = params[:status].to_i
      @tasks = Task.status_search(@status)
    elsif params[:title] && params[:status].blank?
       @tasks = Task.title_search(params[:title])
    elsif params[:title] && params[:status]
       @status = params[:status].to_i
       @tasks = Task.title_search(params[:title]).status_search(@status)
    else
      @tasks = Task.all.order(created_at: :desc)
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
