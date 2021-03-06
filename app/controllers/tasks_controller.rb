class TasksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(task_params)
      flash.clear
      flash[:notice] = "Task updated."
    else
      flash.clear
      flash[:error] = "Error updating task."
    end
    
    respond_with(@task) do |f|
      f.html { redirect_to root_path}
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash.clear
      flash[:notice] = "New task added."
    else
      flash.clear
      flash[:error] = "You can't create an empty task!"
    end

    respond_with(@task) do |f|
      f.html { redirect_to root_path }
    end
  end

  def destroy
    @task = Task.find(params[:id])

    if @task.destroy
      flash.clear
      flash[:notice] = "Task deleted."
    else
      flash.clear
      flash[:error] = "Error deleting task."
    end
    
    respond_with(@task) do |f|
      f.html { redirect_to root_path }
    end
  end

  def complete
    @task = Task.find(params[:id])
    
    if @task.update(complete: true)
      flash.clear
      flash[:notice] = "Task completed. Good job!"
    else
      flash.clear
      flash[:error] = "Error completing task."
    end

    respond_with(@task) do |f|
      f.html { redirect_to root_path }
    end
  end

  def incomplete
    @task = Task.find(params[:id])

    if @task.update(complete: false)
      flash[:notice] = "It's not done after all!"
    else
      flash[:error] = "Error setting this task as incomplete."
    end
    
    respond_with(@task) do |f|
      f.html { redirect_to root_path }
    end
  end
  
  private

  def task_params
    params.require(:task).permit(:name, :complete)
  end
end
