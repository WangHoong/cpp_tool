class Api::Internal::TasksController < ApplicationController
  # Get /tasks
  def index
    @tasks = Task.includes(:album).where(status: 0).limit(1)
    render json: @tasks,
      each_serializer: Api::V1::TaskSerializer
  end

  # Put /tasks/:id
  def update
    status = params[:status] || 2
    @task = Task.find(params[:id])
    @task.album.sync_status = params[:status] if params[:status].present?
    @task.album.sync_time = DateTime.now if params[:status].present?
    @task.batch_no = params[:batch_no] if params[:batch_no].present?
    @task.status = params[:status] if params[:status].present?
    if @task.save
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end
end
