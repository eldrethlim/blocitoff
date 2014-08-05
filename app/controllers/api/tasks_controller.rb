class Api::TasksController < ApplicationController
  skip_before_action :verify_authenticity_token

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

  def update
    user = User.find(params[:user_id])
    task = user.tasks.find(params[:id])
    task.update_attributes(task_params)
    render json: task
  end

  def destroy
    user = User.find(params[:user_id])
    task = user.tasks.find(params[:id])
    if task.destroy
      render json: {'result' => 'Deleted'}
    else
      render json: {'result' => 'Failed'}
    end
  end

  private

    def task_params
      params.require(:task).permit(:name, :complete)
    end
end