class Api::TasksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :check_user_auth

  respond_to :json

  def index
    user = User.friendly.find(params[:user_id])
    tasks = user.tasks.all
    if current_user == user
      render json: tasks
    else
      display_task_error
    end
  end

  def create
    user = User.friendly.find(params[:user_id])
    if current_user == user
      task = user.tasks.build(task_params)
      task.save
      render json: task
    else
      display_task_error
    end
  end

  def update
    user = User.friendly.find(params[:user_id])
    task = user.tasks.find(params[:id])
    if current_user == user
      task.update_attributes(task_params)
      render json: task
    else
      display_task_error
    end
  end

  def destroy
    user = User.friendly.find(params[:user_id])
    task = user.tasks.find(params[:id])
    if current_user == user
      if task.destroy
        render text: "Task deleted"
      else
        render json: "Error deleting task"
      end
    else
      display_task_error
    end
  end

  private

    def check_user_auth
      authenticate_or_request_with_http_basic do |username,password|
        resource = User.find_by_username(username)
          if resource.valid_password?(password)
            sign_in :user, resource
          else
            render text: "Invalid login details"
          end
      end
    end

    def display_task_error
      render text: "You are not authorized to perform this task"
    end

    def task_params
      params.require(:task).permit(:name, :complete)
    end
end