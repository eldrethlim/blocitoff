class WelcomeController < ApplicationController
  def index
    if current_user
      @newtask = Task.new
      @tasks = current_user.tasks.all
    end
  end
end
