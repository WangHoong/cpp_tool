class Api::Internal::TasksController < ApplicationController
  # Get /tasks
  def index
    @tasks = Task.includes(:album).where(status: 0).limit(1)
    render json: @tasks
  end
end
