class Api::TasksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :check_user_auth

  respond_to :json

  def index
    user = User.friendly.find(params[:user_id])
    tasks = user.tasks.all
    render json: tasks
  end

  def create
    user = User.friendly.find(params[:user_id])
    task = user.tasks.build(task_params)
    task.save
    render json: task
  end

  def update
    user = User.friendly.find(params[:user_id])
    task = user.tasks.find(params[:id])
    task.update_attributes(task_params)
    render json: task
  end

  def destroy
    user = User.friendly.find(params[:user_id])
    task = user.tasks.find(params[:id])
    if task.destroy
      render json: {'result' => 'Deleted'}
    else
      render json: {'result' => 'Failed'}
    end
  end

  private

    def check_user_auth
      authenticate_or_request_with_http_basic do |username,password|
        resource = User.find_by_username(username)
          if resource.valid_password?(password)
            sign_in :user, resource
          end
      end
    end

    def task_params
      params.require(:task).permit(:name, :complete)
    end
end