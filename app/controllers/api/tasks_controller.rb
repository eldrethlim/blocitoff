class Api::TasksController < ApplicationController
  def index
    user = User.find(params[:user_id])
    tasks = user.tasks.all
    render json: tasks
  end

  def create
    user = User.find(params[:user_id])
    task = user.tasks.build(task_params)
    task.save
    render json: task
  end

  private
    def task_params
      params.require(:task).permit(:name, :complete)
    end
end