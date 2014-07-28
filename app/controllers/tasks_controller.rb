class TasksController < ApplicationController
  before_filter :authenticate_user!

  def create
    @task = current_user.tasks.build(params.require(:task).permit(:name))
    if @task.save
      flash[:notice] = "Task added"
    else
      flash[:error] = "Task not added"
    end
    redirect_to root_path
  end
end
