class TasksController < ApplicationController
  
  def index
    list
    render :action => :list
  end
  
  def list
    @tasks = Task.find :all
  end
  
  def show
    @task = Task.find params[:id] 
  end
  
  def new
    @task = Task.new
    @users = User.find :all, :select => 'id, login'
  end
  
  def create
    @task = Task.new params[:task]
    if @task.save
      flash[:notice] = 'Задание успешно сохранено!'
      redirect_to task_path @task
    else
      flash[:error] = 'Ошибка при добавлении задания'
      render :action => :new
    end
  end
end
