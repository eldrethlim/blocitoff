class TasksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(task_params)
      flash[:notice] = "Task updated."
    else
      flash[:error] = "Error updating task."
    end
    redirect_to root_path
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:notice] = "New task added."
    else
      flash[:error] = "Error adding task."
    end

    respond_with(@task) do |f|
      f.html { redirect_to root_path }
    end
  end

  def destroy
    @task = Task.find(params[:id])

    if @task.destroy
      flash[:notice] = "Task deleted."
    else
      flash[:error] = "Error deleting task."
    end
    redirect_to root_path
  end

  def complete
    @task = Task.find(params[:id])
    
    if @task.update(complete: true)
      flash[:notice] = "Task completed. Good job!"
    else
      flash[:error] = "Error completing task."
    end
    redirect_to root_path
  end

  def incomplete
    @task = Task.find(params[:id])

    if @task.update(complete: false)
      flash[:notice] = "It's not done after all!"
    else
      flash[:error] = "Error setting this task as incomplete."
    end
    redirect_to root_path
  end
  
  private

  def task_params
    params.require(:task).permit(:name, :complete)
  end
end
