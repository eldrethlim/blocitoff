class WelcomeController < ApplicationController
  def index
    if current_user
      @tasks = current_user.tasks.all
    end
  end
end
