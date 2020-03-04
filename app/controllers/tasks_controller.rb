class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_deadline]
      @tasks = Task.all.order(deadline: :asc)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :desc)
    elsif params[:title].blank? && params[:status]
      @tasks = Task.where('status LIKE ?', "%#{params[:status]}%")
    elsif params[:title]
      @tasks = Task.where('title LIKE ?', "%#{params[:title]}%")
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

    # def order_string
    #   return 'created_at DESC' unless params.key?(:order)
    #   order_params.to_h.map { |key, val| "#{key} #{val.upcase}" }.join(',')
    # end
    #
    # def prepare_search_attr
    #   @search_attr = { title: '' }
    #   @search_attr = task_params.delete_if { |_key, val| val.blank? } if params.key?(:task)
    # end

    def task_params
      params.require(:task).permit(:title, :content, :deadline, :priority, :status, :user_id)
    end

    # def order_params
    #   params.require(:order).permit(:deadline, :priority)
    # end

end
