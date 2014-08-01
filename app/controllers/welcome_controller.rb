class WelcomeController < ApplicationController
  def index
    if current_user
      @tasks = current_user.tasks.all.order('tasks.created_at DESC')
    end
  end
end
