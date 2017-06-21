class Api::V1::TasksController < Api::V1::BaseController
  # Post /tasks
  def create
    puts "=============="
    puts params.to_json
    puts "=============="
    @tasks = params.require(:task_ids).map do |id|
      if Task.find_by(:album_id => id, :status => 0)
        "任务已存在"
      else
        task = Task.new(:album_id => id)
        task.save
      end
    end
    puts "=============="
    puts @tasks.to_json
    puts "=============="
    if @tasks
      render json: @tasks
    else
      render json: @tasks.errors, status: :unprocessable_entity
    end
  end
end
