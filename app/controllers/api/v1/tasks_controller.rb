class Api::V1::TasksController < Api::V1::BaseController
  # Post /tasks
  def create
    puts "=============="
    puts params.to_json
    puts "=============="
    @tasks = params.require(:album_ids).map do |id|
      if Task.find_by(:album_id => id, :status => 0)
        {
          id: id,
          success: false,
          message: "此任务正在等待处理中,请不要重复提交。"
        }
      else
        if !Album.find_by(:id => id)
          {
            id: id,
            success: false,
            message: "没有此album"
          }
        else
          task = Task.new(:album_id => id)
          if task.save
            {
              id: id,
              success: true
            }
          else
            {
              id: id,
              success: false,
              message: "创建失败请重试，或联系管理员。"
            }
          end
        end
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
