class TasksController < ApplicationController
  before_filter :authenticate_user!

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
    redirect_to root_path
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

  private

  def task_params
    params.require(:task).permit(:name)
  end
end
